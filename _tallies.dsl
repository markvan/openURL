isbns
  match
    field = isbn
    pattern = /./
  group = isbn btitle

books_with_title
  match
    field = btitle
    pattern = /./
  match
    field = title
    pattern = /./
  group = btitle

books_with_given_title
  match
    field = btitle
    pattern = /Numerical Simulations/
  group = institutionResolverID encryptedUserID btitle

sid_targets
  match
    field = sid
    pattern = /./
  group = sid.gsub(/(:|\/).*$/,"")
