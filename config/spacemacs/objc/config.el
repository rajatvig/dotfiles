(defadvice ff-get-file-name (around ff-get-file-name-framework
                              (search-dirs
                                fname-stub
                                &optional suffix-list))
  "Search for Mac framework headers as well as POSIX headers."
  (or
    (if (string-match "\\(.*?\\)/\\(.*\\)" fname-stub)
      (let* ((framework (match-string 1 fname-stub))
              (header (match-string 2 fname-stub))
              (fname-stub (concat framework ".framework/Headers/" header)))
        ad-do-it))
    ad-do-it))

(ad-enable-advice 'ff-get-file-name 'around 'ff-get-file-name-framework)

(ad-activate 'ff-get-file-name)

(setq cc-search-directories '("." "../include" "/usr/include" "/usr/local/include/*"
                               "/System/Library/Frameworks" "/Library/Frameworks"))
