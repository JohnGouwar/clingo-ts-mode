# clingo-ts-mode
An Emacs major mode for AnsProlog (as provided by clingo) powered by treesitter

# Prerequisites and Setup

Emacs 29+ compiled with tree-sitter support, and the `clingo` treesitter grammar installed: 
```elisp
(add-to-list 'treesit-source-alist '(clingo "https://github.com/potassco/tree-sitter-clingo")
(unless (treesit-language-available-p 'clingo)
	(treesit-install-language-grammar 'clingo))
```

# Installation 
This package is not yet hosted on MELPA, but can be installed using `package-vc-install` and `vc-use-package`:
```elisp 
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)
(use-package clingo-ts-mode
  :vc (clingo-ts-mode :url "https://github.com/JohnGouwar/clingo-ts-mode"
		      :branch "main")
  :config
  (add-to-list 'auto-mode-alist '("\\.lp" . clingo-ts-mode)))
```

`vc-use-package` is not strictly necessary, and is actually included in Emacs 30. 

# Usage 

This package is a work in progress and provides basic syntax highlighting and indentation for 
AnsProlog code. I wrote this mostly as a way to experiment with writing treesitter major modes, 
For a more featureful `clingo-mode` check out: https://github.com/llaisdy/clingo-mode (whose `syntax-table` I copied). 
