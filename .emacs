;
;  老郭的.emacs文件。
;  环境： ubuntu 10.4,  emacs 23.2.1     
;

;;Personal information
(setq user-full-name "Chris Guo")
(setq user-mail-address "guoxianghao@gmail.com")

;
(setq initial-frame-alist '((top . 0) (left . 0) (width . 130) (height . 49)))

; set default dir
(setq default-directory "/home/guoxianghao/")

(setq scroll-margin 3  scroll-conservatively 10000)



(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(font-lock-comment-face ((((class color) (background dark)) (:foreground "dark orange"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "yellowgreen"))))
 '(highlight ((((class color) (background dark)) (:background "#252525")))))

(setq current-language-environment "utf-8")
(setq locale-coding-system 'utf-8)

; when two files with the same file name read in buffers,
; the buffer name will be the full path name so make the two buffer different.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


;; Spell Check (aspell needed.)

; 拼写检查。其实，对於非中文，没啥子用处。去掉能省内存。
;(require 'ispell)
;(setq-default ispell-program-name "aspell")
;(setq-default ispell-extra-args '("--reverse"))


;Title name of Buffer
(setq frame-title-format "%b")
;load path
(setq load-path (append
                 load-path
                 '("/home/guoxianghao/.emacs.d/")
                 ))

(add-to-list 'load-path
			 "~/.emacs.d/emacs-goodies-el")

;记录最近打开的文件,下次使用起来方便。
;record the recent opened files so can be recalled next time.

 (require 'recentf)
 (recentf-mode 1)

 
;(highlight-current-line-on 1)

(global-hi-lock-mode 1)

; hight light current line when idle
(require 'hl-line+)
(toggle-hl-line-when-idle 1)


;try company, which is completion
; 对於一些编程语言比较好用，但是。。。。。有不有更好用的模式。
(add-to-list 'load-path "~/.emacs.d/company")
(autoload 'company-mode "company" nil t)

;
(setq inhibit-startup-message t)

;(tool-bar-mode -1)

(require 'ido)
(setq ido-enable-prefix nil)
(setq ido-enable-case nil)
(ido-mode t)

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-14"))
;          
;(set-scroll-bar-mode nil)



;;-------------------------------------------------------------------------

(autoload 'remember "remember" nil t)
(autoload 'remember-region "remember" nil t)


;; Remove the some buttons in the tool bar.
(defvar need-delete-toolbar-buttons '(print-buffer))
(when (boundp 'tool-bar-map)
  (let ((need-delete-btns))
    (dolist (button tool-bar-map)
      (when (and (consp button)
                 (memq (car button) need-delete-toolbar-buttons))
        (add-to-list 'need-delete-btns button)))
    (dolist (button need-delete-btns)
      (delq button tool-bar-map))))

;;-------------------------------------------------------------------------
; try to add item in menu
 (require 'easymenu)
(easy-menu-remove-item global-map '("menu-bar" "tools") 'games)
(easy-menu-add-item nil '("tools") ["Ruby1.9.2检查语法" execute-ruby192-check-syntax t])
(easy-menu-add-item nil '("tools") ["Ruby1.9.2运行" execute-ruby192 t])


(tool-bar-add-item "gud/nexti" 'execute-ruby192-check-syntax '用ruby192检查当前代码的语法
                  :enable '(memq major-mode '(ruby-mode)))

(tool-bar-add-item "gud/go" 'execute-ruby192 '用ruby192运行当前代码
                  :enable '(memq major-mode '(ruby-mode)))



;;-------------------------------------------------------------------------
;启动加密解密功能。
;把当前文件存为.gpg格式的时候，系统会提示设置密码然后进行对称加密保存。打开.gpg格式的文件，系统也会
;要求输入密码先解密。
;;-------------------------------------------------------------------------

(require 'epa-file)
;(epa-file-enable)


;;-------------------------------------------------------------------------
; 缺省的颜色设定。; 缺省的颜色设定。
(setq default-frame-alist
 '(
    (foreground-color . "green")
    (background-color . "black")
    (cursor-color     . "#00DD00")
   )
)


(setq-default kill-whole-line t)
;Display time 
(display-time-mode 1)
;Display column number
(column-number-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)

;f1键，出info
(global-set-key [f1] 'info)
;f2存盘
(global-set-key [(f2)] 'save-buffer)
;f3 is begining of record macro

;f4 is the end of recod macro

;f5  和备份进行对比。
(global-set-key [f5] 'ediff-backup)
;f6  转换只读
(global-set-key [f6] 'view-mode)
; f7
; 高亮鼠标所在文字，很实用。
; 都用f7来搞。
; High light symbols at point, or find the next/prev one.
;
 (require 'highlight-symbol)
 (global-set-key [f7] 'highlight-symbol-at-point)
 (global-set-key [(control f7)] 'highlight-symbol-next)
 (global-set-key [(shift f7)] 'highlight-symbol-prev)
 (global-set-key [(meta f7)] 'highlight-symbol-prev)
 (global-set-key [(control meta f7)] 'highlight-symbol-query-replace)


(global-set-key (kbd "M-g") 'goto-line)
;; M-g  goto-line

;C_Z  undo
(global-set-key "\C-z" 'undo)
; C_\ 灭掉当前buffer
(global-set-key "\C-\\" 'kill-buffer)

;f9
;可以用f9来观察和选中kill ring的某个东西，很给力。
(require 'browse-kill-ring)
(global-set-key (kbd "<f9>") 'browse-kill-ring)


;f10
(global-set-key [f10] 'query-replace)

;reload the file
(defun reload-file ()
  (interactive)
  (let ((curr-scroll (window-vscroll)))
    (find-file (buffer-name))
    (set-window-vscroll nil curr-scroll)
    (message "Reloaded file")))
 
(global-set-key "\C-c\C-r" 'reload-file)


;control-space reserved for Chinese input
(global-set-key [(control space)] nil)
;
(mouse-avoidance-mode 'animate)
; yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;

(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;

(setq auto-image-file-mode t)
;;   Emacs      ±   ò              

(put 'scroll-left 'disabled nil)     ;
(put 'scroll-right 'disabled nil)    ;

; Press Ctroll-F to duplicate current line

(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))

(global-set-key (kbd "C-f") 'duplicate-line)


;
(setq calendar-load-hook
'(lambda ()
(set-face-foreground 'diary-face "skyblue")
(set-face-background 'holiday-face "slate blue")
(set-face-foreground 'holiday-face "white")))

(setq calendar-latitude +39.54)
(setq calendar-longitude +116.28)
(setq calendar-location-name "±±  ")

(setq chinese-calendar-celestial-stem
  [" ×" "  " "± " "  " " ì" "  " "  " "  " "  " "  "])
(setq chinese-calendar-terrestrial-branch
  ["× " " ó" " ú" "  " "  " "  " " ì" "  " " ê" "  " "  " "  "])


;缺省是abbrev模式
(setq-default abbrev-mode t)
;从这里加载缩写数据
(read-abbrev-file "~/.emacs.d/.abbrev_defs")

(setq save-abbrevs t)

; kill ring 设置为150
(setq kill-ring-max 150)

; no fill mode for ever
(setq auto-fill-mode -1) 
(setq fill-column 99999) 
(setq-default fill-column 99999)

;(diary)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-time-mode t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines nil)
  '(overline-margin 3)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-scale-mode-step 1.5)
 '(toolbarshow-edit nil)
 '(toolbarshow-program nil)
 '(toolbarshow-view nil))

;;            fundemental-mode    text-mode
(setq default-major-mode 'text-mode)

;设定备份目录和备份策略。
(setq backup-directory-alist '(("" . "~/backup/emacs/backup")))
(setq-default make-backup-file t)
(setq make-backup-file t)

(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 10)
(setq delete-old-versions t)

;try pick up
;获取备份文件的接口,后面可以直接用它的函数获得当前buffer的备份文件进行可视化对比。
(require 'pick-backup)
;新开窗口来运行eshell
(defun open-eshell-other-buffer ()
"Open eshell in other buffer"
(interactive)
(split-window-vertically)
(eshell))

;m-k直接干掉光标之后的剩余文字。
(global-set-key (kbd "M-k") 'kill-line)


(require 'tabbar)
(tabbar-mode)
(global-set-key (kbd "M-[") 'tabbar-backward-group)
(global-set-key (kbd "M-]") 'tabbar-forward-group)
(global-set-key (kbd "M-p") 'tabbar-backward-tab)
(global-set-key (kbd "M-n") 'tabbar-forward-tab)

;存放bookmark的地方
(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")

;
;Fast Bookmark
;快捷bookmark， 用C_.和C_,来搞。
;
(global-set-key [(control ?.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
  Use ska-jump-to-register to jump back to the stored
  position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
  that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))


(defun my-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %.
Argument ARG paren."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
   ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
   (t (self-insert-command (or arg 1)))))

;;{{{ go-to-char
(defun my-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `my-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
           char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
;;}}}


;; 在括号那里匹配反括号，不太好用，暂时灭之。
;(global-set-key "%" 'my-match-paren)

;; visual line mark
 (require 'bm)
  (global-set-key (kbd "<f11>") 'bm-toggle)
  (global-set-key (kbd "<C-f11>")   'bm-next)
  (global-set-key (kbd "<S-f11>") 'bm-previous)

;bookmark
  (global-set-key (kbd "<f12>") 'bookmark-bmenu-list)
  (global-set-key (kbd "<C-f12>")   'bookmark-set)
  (global-set-key (kbd "<S-f12>") 'bookmark-jump)

;实用外部的meld来可视化地对比当前文件和它的备份。
;确保meld已经安装了。
(defun meld(file)
  (interactive (list (buffer-file-name)))
  (unless file (setq file (buffer-file-name)))
  (setq cmd (concat "meld  " (pick-backup-file file)  " " file))  
  (message "%s ..." cmd)  
  (shell-command cmd) 

)


;------------  try ruby 1.9.2 --------------------------------------
; 假设ruby 1.9.2 安装在 /home/guoxianghao/.rvm/rubies/ruby-1.9.3-p327/bin/ruby 
 ;; execute ruby using 1.9.2 
 (defun execute-ruby192()  
  "excute ruby 1.9.2"  
  (interactive)  
  (let ((filename buffer-file-name)  
        (cmd "")  
        (oldbuf (current-buffer))  
        (end (point-max)))  
    (if filename  
        (save-buffer)  
      (save-excursion  
        (setq filename (concat (getenv "tmp") "/temp.rb"))  
        (set-buffer (create-file-buffer filename))  
        (insert-buffer-substring oldbuf 1 end)  
        (write-file filename)  
        (kill-buffer (current-buffer))))  
    (setq cmd (concat "/home/guoxianghao/.rvm/rubies/ruby-1.9.3-p327/bin/ruby  " filename))  
    (message "%s ..." cmd)  
    (shell-command cmd)))  


 ;; execute ruby syntax checing using 1.9.2
 (defun execute-ruby192-check-syntax()  
  "excute ruby 1.9.2 check syntax"  
  (interactive)  
  (let ((filename buffer-file-name)  
        (cmd "")  
        (oldbuf (current-buffer))  
        (end (point-max)))  
    (if filename  
        (save-buffer)  
      (save-excursion  
        (setq filename (concat (getenv "tmp") "/temp.rb"))  
        (set-buffer (create-file-buffer filename))  
        (insert-buffer-substring oldbuf 1 end)  
        (write-file filename)  
        (kill-buffer (current-buffer))))  
    (setq cmd (concat "/home/guoxianghao/.rvm/rubies/ruby-1.9.3-p327/bin/ruby  -c  " filename))  
    (message "%s ..." cmd)  
    (shell-command cmd)))  

;; incease or decrease the text front
(global-set-key (kbd "<C-mouse-4>") 'text-scale-decrease)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-increase)
; mark set as Shift-Space
(global-set-key [?\S- ] 'set-mark-command) 

;;-------按home键到buffer开始，按end键到buffer末尾。
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)




;-------- yasnippet begin--------------------------------------------------
 (add-to-list 'load-path
                  "~/.emacs.d/yasnippet-0.6.1c")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/.emacs.d/yasnippet-0.6.1c/snippets")
;--------------------------------------------------------------------------


;; -------- ORG mode begin
;--------------------------------------------------------------------------
  (setq load-path (cons "~/.emacs.d/org-7.9.1/lisp" load-path))
  (setq load-path (cons "~/.emacs.d/org-7.9.1/contrib/lisp" load-path))
  (require 'org-install)
  (setq org-support-shift-select t)  
;  给已完成事项打上时间戳。可选note，附加注释
  (setq org-log-done 'time)
  (global-set-key [(control f6)] 'org-store-link)
;--------------------------------------------------------------------------
;; -------- ORG mode end




(tool-bar-add-item "gud/down" 'my-dup-line-down '复制当前行 )
(tool-bar-add-item "bookmark_add" 'bookmark-set '当前位置设为书签 )
(tool-bar-add-item "index" 'bookmark-bmenu-list '显示书签单子 )
(tool-bar-add-item "gud/cont"  'bm-toggle '当前位置设为书签并高亮 )
(tool-bar-add-item "gud/step"  'bm-next '跑到高亮的书签处 )
(tool-bar-add-item "next-page"  'meld '运行meld进行版本文本比较 )
(tool-bar-add-item "show"  'delete-other-windows '当前窗口最大化 )

(global-set-key [(control ?\')] 'hippie-expand)
(global-set-key [(control ?\;)] 'hippie-expand)

(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))


(defun my-insert-date ()
  (interactive)
  (insert (format-time-string "%Y年%m月%d日 %H:%M:%S" (current-time))))

(global-set-key (kbd "C-c i d") 'my-insert-date)

; use git
; first you should compile it, it is localed in git source under /contrib/git, get git.elc, when
; copy it to the ~/emacs.d/ dir. 
; (require 'git)

;
;这部分，记载当前session， 下次加载的时候自动恢复。
;需要放在.emacs文件的最后面。
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(load "desktop")
(desktop-load-default)
(desktop-save-mode)
;(desktop-read)

