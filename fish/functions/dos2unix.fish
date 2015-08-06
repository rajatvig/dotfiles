function dos2unix
  for file in (find $argv -type f)
    tr -d '\r' <$file > /tmp/tmp.out ; mv /tmp/tmp.out $file
  end
end
