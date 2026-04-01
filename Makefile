# Makefile for AMD Instinct Getting Started documentation
#
# Targets:
#   html        Build HTML via Sphinx
#   latex       Build LaTeX source via Sphinx
#   pdf         Build PDF via LaTeX (requires latexmk)
#   epub        Build EPUB via Sphinx
#   docx        Convert EPUB to DOCX via pandoc (requires epub + pandoc)
#   all         Build HTML, PDF, EPUB, and DOCX
#   lint        Run markdownlint on all docs source files
#   lint-fix    Run markdownlint --fix on all docs source files
#   clean       Remove all build artifacts
#
# Sphinx options can be overridden at the command line:
#   make html SPHINXOPTS="-W --keep-going"   # treat warnings as errors (CI-style)

SPHINXBUILD   ?= sphinx-build
SOURCEDIR      = docs
BUILDDIR       = docs/_build
SPHINXOPTS    ?=
EPUB_FILE      = $(BUILDDIR)/epub/*.epub
DOCX_OUT       = $(BUILDDIR)/docx/instinct-getting-started.docx

.PHONY: help html latex pdf epub docx all lint lint-fix clean

help:
	@echo ""
	@echo "AMD Instinct Getting Started — documentation build targets"
	@echo ""
	@echo "  Build:"
	@echo "    html       HTML via Sphinx"
	@echo "    latex      LaTeX source via Sphinx"
	@echo "    pdf        PDF via LaTeX + latexmk  (depends on: latex)"
	@echo "    epub       EPUB via Sphinx"
	@echo "    docx       DOCX via pandoc           (depends on: epub)"
	@echo "    all        HTML + PDF + EPUB + DOCX"
	@echo ""
	@echo "  Lint:"
	@echo "    lint       markdownlint check (uses .markdownlint.yaml)"
	@echo "    lint-fix   markdownlint --fix (auto-corrects fixable issues)"
	@echo ""
	@echo "  Utility:"
	@echo "    clean      Remove docs/_build/"
	@echo ""
	@echo "  Override Sphinx options:"
	@echo "    make html SPHINXOPTS=\"-W --keep-going\"  # warnings as errors"
	@echo ""

# ---------------------------------------------------------------------------
# Build targets
# ---------------------------------------------------------------------------

html:
	$(SPHINXBUILD) -b html $(SPHINXOPTS) $(SOURCEDIR) $(BUILDDIR)/html
	@echo ""
	@echo "HTML build complete: $(BUILDDIR)/html"
	@echo "Open: $(BUILDDIR)/html/index.html"

latex:
	$(SPHINXBUILD) -b latex $(SPHINXOPTS) $(SOURCEDIR) $(BUILDDIR)/latex
	@echo ""
	@echo "LaTeX source ready: $(BUILDDIR)/latex"

pdf: latex
	@echo "Building PDF with latexmk..."
	$(MAKE) -C $(BUILDDIR)/latex LATEXMKOPTS="-silent"
	@echo ""
	@echo "PDF build complete: $(BUILDDIR)/latex/*.pdf"

epub:
	$(SPHINXBUILD) -b epub $(SPHINXOPTS) $(SOURCEDIR) $(BUILDDIR)/epub
	@echo ""
	@echo "EPUB build complete: $(BUILDDIR)/epub"

docx: epub
	@echo "Converting EPUB to DOCX via pandoc..."
	@mkdir -p $(BUILDDIR)/docx
	pandoc $(EPUB_FILE) -o $(DOCX_OUT)
	@echo ""
	@echo "DOCX build complete: $(DOCX_OUT)"

all: html pdf epub docx

# ---------------------------------------------------------------------------
# Lint targets
# ---------------------------------------------------------------------------

# Runs markdownlint against all .md files under docs/, respecting
# .markdownlint.yaml (config) and .markdownlintignore (exclusions).
lint:
	markdownlint --config .markdownlint.yaml "docs/**/*.md"

lint-fix:
	markdownlint --config .markdownlint.yaml --fix "docs/**/*.md"

# ---------------------------------------------------------------------------
# Utility
# ---------------------------------------------------------------------------

clean:
	rm -rf $(BUILDDIR)
	@echo "Removed $(BUILDDIR)"
