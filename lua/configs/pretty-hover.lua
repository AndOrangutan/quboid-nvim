local quboid = require('quboid')

require('pretty_hover').setup({
	line = {
		"@brief",
	},
	listing = {
		"@li",
	},
	word = {
		"@param",
		"@tparam",
		"@see",
		"@*param*", -- for lua
	},
	header = {
		"@class",
	},
	return_statement = {
		"@return",
		"\\return",
		"@*return*", -- for lua
	},
	references = {
		"@ref",
		"@c",
		"@name",
	},
	stylers = {
		line = '**',
		word = '`',
		header = '###',
		listing = " - ",
		references = {
			"**", -- Used primarly in main body.
			"`" -- Used in brief section.
		},
	},
	border = quboid.border,
	max_width = nil, -- Leave nil for no restriction.
	max_height = nil, -- Leave nil for no restriction.
})
