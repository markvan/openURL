tally isbn
  for records where isbn matches /./
  tally by isbn

tally books_with_title
  for records where btitle matches /./
    or records where title matches /./
  tally by btitle

tally books_with_given_title
  for records where btitle matches /Numerical Simulations/
  tally by institutionResolverID encryptedUserID btitle

tally sid_targets
  for records where sid matches /./
  tally by sid.gsub(/(:|\/).*$/,"")
