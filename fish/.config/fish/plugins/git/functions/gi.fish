#From https://www.gitignore.io/docs

function gi --description='create .gitignore'
  curl -L -s https://www.gitignore.io/api/$argv
end
