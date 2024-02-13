local util = require 'lspconfig.util'

local opts = {
	enable_editor_support = true,
	enable_ms_build_load_projects_on_demand = true,
	enable_roslyn_analyzers = true,
	organize_imports_on_format = false,
	enable_import_completion = true,
	sdk_include_prereleases = true,
	analyze_open_documents_only = true,

	filetypes = { "cs", "vb" },
}
return opts
