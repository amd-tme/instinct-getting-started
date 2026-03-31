"""Configuration file for the Sphinx documentation builder."""

import os

html_baseurl = os.environ.get("READTHEDOCS_CANONICAL_URL", "instinct.docs.amd.com")
html_context = {}
if os.environ.get("READTHEDOCS", "") == "True":
    html_context["READTHEDOCS"] = True
project = "instinct-getting-started"

version = "0.1.0"
release = version
html_title = "Getting Started"
author = "Advanced Micro Devices, Inc."
copyright = "Copyright (c) 2025 Advanced Micro Devices, Inc. All rights reserved."

# Required settings
html_theme = "rocm_docs_theme"
html_theme_options = {
    "flavor": "instinct",
    "link_main_doc": True,
}
extensions = ["rocm_docs", "sphinx.ext.imgconverter"]

# Table of contents
external_toc_path = "./sphinx/_toc.yml"

exclude_patterns = [".venv"]

html_static_path = ["_static"]
html_css_files = ["css/journey.css"]
