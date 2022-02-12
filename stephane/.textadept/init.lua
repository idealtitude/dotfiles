-- Adjust the default theme's font and size.
if not CURSES then
  view:set_theme('base16-eighties', {font = 'Source Code Pro', size = 11})
end

-- Always use tabs for indentation.
buffer.use_tabs = true
buffer.tab_width = 4

buffer.wrap_mode = buffer.WRAP_WHITESPACE

-- Always strip trailing spaces on save, automatically highlight the current
-- word, and use C99-style line comments in C code.
textadept.editing.strip_trailing_space = true
--textadept.editing.highlight_words = textadept.editing.HIGHLIGHT_CURRENT
textadept.editing.comment_string.ansi_c = '//'

-- Load an external module and bind a key to it.
local ctags = require('ctags')
keys.f12 = ctags.goto_tag

-- Recognize .luadoc files as Lua code.
textadept.file_types.extensions.luadoc = 'lua'

-- Change the run commands for Lua and Python
textadept.run.run_commands.lua = 'lua5.1 "%f"'
textadept.run.run_commands.python = 'python3 "%f"'

textadept.editing.autocomplete_all_words = true

-- Always use PEP-8 indentation style for Python files.
--events.connect(events.LEXER_LOADED, function(name)
--  if name ~= 'python' then return end
--  buffer.use_tabs = false
--  buffer.tab_width = 4
--end)

snippets['ini'] = '#include <iostream>%0'
snippets['inv'] = '#include <vector>%0'
snippets['ins'] = '#include <string>%0'
snippets['inm'] = '#include <map>%0'
snippets['inme'] = '#include <memory>%0'
snippets['inr'] = '#include <regex>%0'
snippets['inc'] = '#include <chrono>%0'
snippets['inf'] = '#include <fstream>%0'
snippets['int'] = '#include <thread>%0'
snippets['infs'] = '#include <filesystem>%0'
snippets['inti'] = '#include <typeinfo>%0'
snippets['intt'] = '#include <type_traits>%0'
snippets['in'] = '#include %0'
snippets['ma'] = 'int main(int argc, char **argv)\n{\n\t%0\n\treturn 0;\n}'
snippets['mav'] = 'int main()\n{\n\t%0\n\treturn 0;\n}'
snippets['gl'] = 'std::getline(std::cin, %0);'
snippets['s'] = 'std::%0'
snippets['str'] = 'std::string%0'
snippets['co'] = 'std::cout << %0'
snippets['ci'] = 'std::cin >> %0'
snippets['cig'] = 'std::cin.ignore()%0'
snippets['cic'] = 'std::cin.clear()%0'
snippets['cer'] = 'std::cerr << %0'
snippets['en'] = '%0 << std::endl;'
snippets['ce'] = 'std::cout << %0 << std::endl;'
snippets['cl'] = 'std::cout << %0 << \'\n\';'
snippets['if'] = 'if (%0)\n{\n\t%1\n}'
snippets['ife'] = 'if (%0)\n{\n\t%1\n}\nelse\n{\n}'
snippets['ifi'] = 'if (%0)\n{\n\t%1\n}\nelse if\n{\n}\nelse\n{\n}'
snippets['for'] = 'for (int i = 0; i < %0; ++i)\n{\n\t%1\n}'
snippets['fori'] = 'for (auto &e : %0)\n{\n\t%1\n}'
snippets['whi'] = 'while (%0)\n{\n\t%1\n}'
snippets['cls'] = 'class %0\n{\n  public:\n\t%0();\n\t~%0();\n  private:\n\tint x;\n};'
snippets['hdr'] = '#ifndef %0_H\n#define %0_H\n\n\n#endif\n'
snippets['ns'] = 'namespace %0\n{\n\t\n}\n'
snippets['swi'] = 'switch (%1)\n{\n\tcase %0:\n\t\t\n\t\tbreak;\n}\n'
snippets['stc'] = 'struct %0\n{\n\t\n};\n'
snippets['vec'] = 'std::vector<%0>'
snippets['map'] = 'std::map<%0, >'
snippets['tpl'] = 'template <typename T>%0'
snippets['ths'] = 'std::this_thread::sleep_for(std::chrono::seconds(%0))'
snippets['thm'] = 'std::this_thread::sleep_for(std::chrono::milliseconds(%0))'
snippets['vecit'] = 'std::vector<%0>::iterator %1'
snippets['forem'] = 'for (%0; ; )\n{\n\t%1\n}\n'
snippets['mapit'] = 'std::map<%2, %1>::iterator %0'
snippets['lmb'] = '[%0](){}'
snippets['sptr'] = 'std::shared_ptr<%0>'
snippets['uptr'] = 'std::unique-ptr<%0>'
snippets['mshr'] = 'std::make_shared<>(%0)'
snippets['muni'] = 'std::make_unique<>(%0)'
snippets['mov'] = 'std::move(%0)'
snippets['fwd'] = 'std::forward(%0)'
snippets['typid'] = 'typeid(%0).name(%1)'
snippets['mac'] = 'int main(const int argc, const char **argv)\n{\n\t%0\n\treturn 0:\n}\n'
snippets['try'] = 'try\n{\n\t%0;\n}\ncatch (const std::exception& e)\n{\n\t\n}'
