import yaml
from robot.api import logger
from bs4 import BeautifulSoup
from pathlib import Path
import base64
import mimetypes

class LogoListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self, config_yaml):
        """
        Recibe la ruta de un archivo YAML con la configuración.
        """
        config_path = Path(config_yaml)
        if not config_path.exists():
            raise FileNotFoundError(f"No se encontró el archivo de configuración YAML: {config_yaml}")

        with open(config_path, "r", encoding="utf-8") as f:
            config = yaml.safe_load(f)

        self.output_dir = Path(config.get("output_dir", "."))
        self.logo_filename = config.get("logo_filename", "Resources/pruebaLogo.png")
        self.logo_height = int(config.get("logo_height", 60))
        self.title_text = config.get("title_text", "Reporte Automatizado, generado por Netics")
        self.title_color = config.get("title_color", "#003366")

    def close(self):
        """Se ejecuta al final de la ejecución y modifica los reportes HTML."""
        try:
            report_file = self.output_dir / "report.html"
            log_file = self.output_dir / "log.html"

            for html_file in [report_file, log_file]:
                if html_file.exists():
                    self._insert_embedded_logo(html_file)
                    logger.info(f"✅ Logo embebido en {html_file}")
                else:
                    logger.warn(f"⚠️ No se encontró {html_file}")

        except Exception as e:
            logger.error(f"❌ Error insertando logo: {e}")

    def _embed_image_base64(self, image_path: Path) -> str:
        """Convierte una imagen en un string Base64 embebido (data URI)"""
        if not image_path.exists():
            raise FileNotFoundError(f"No se encontró el archivo de logo: {image_path}")

        mime_type, _ = mimetypes.guess_type(image_path)
        if not mime_type:
            mime_type = "image/png"

        with open(image_path, "rb") as f:
            encoded = base64.b64encode(f.read()).decode("utf-8")

        return f"data:{mime_type};base64,{encoded}"

    def _insert_embedded_logo(self, html_file: Path):
        """Inserta el logo embebido y el encabezado en el HTML."""
        html = html_file.read_text(encoding="utf-8")
        soup = BeautifulSoup(html, "html.parser")

        # Cambiar título del navegador
        title_tag = soup.find("title")
        if title_tag:
            title_tag.string = self.title_text
        else:
            new_title = soup.new_tag("title")
            new_title.string = self.title_text
            if soup.head:
                soup.head.append(new_title)

        # Generar data URI del logo
        embedded_logo = self._embed_image_base64(Path(self.logo_filename))

        # Buscar título principal
        main_title = soup.find(["h1", "h2"], string=lambda s: s and ("Log" in s or "Report" in s))

        # Encabezado corporativo
        header_div = soup.new_tag(
            "div",
            style=(
                "display:flex;"
                "align-items:center;"
                "justify-content:center;"
                "gap:20px;"
                "margin-top:25px;"
                "margin-bottom:30px;"
                "font-family:Arial, sans-serif;"
            ),
        )

        # Logo embebido
        logo_img = soup.new_tag(
            "img",
            src=embedded_logo,
            height=str(self.logo_height),
            alt="Logo",
            style="flex-shrink:0;"
        )

        # Texto del encabezado
        title_div = soup.new_tag(
            "div",
            style=(
                f"font-size:1.8em;"
                f"font-weight:bold;"
                f"color:{self.title_color};"
                "text-align:center;"
            )
        )
        title_div.string = self.title_text

        # Insertar logo y título
        header_div.append(logo_img)
        header_div.append(title_div)

        if main_title:
            main_title.insert_before(header_div)
        else:
            body = soup.find("body")
            if body:
                body.insert(0, header_div)

        html_file.write_text(str(soup), encoding="utf-8")
