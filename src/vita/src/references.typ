#import "../../rolo/rolo.typ": *
#let referencelist = state("referencelist", ())

#let reference(
  author,
) = {
  if author != none {
    let content = [
      #stack(
        dir: ltr, 
        spacing: 1fr,
        heading(level: 3, fullname(author.name)),
        address(author).join(", ")
      )
      #stack(
        dir: ltr, 
        spacing: 1fr,
        align(left, stack(dir: ttb, spacing: 0.65em, author.roles, author.affiliation.department, author.affiliation.name)),
        align(right, stack(dir: ttb, spacing: 0.65em, author.email, author.phone, author.url)))
    ]
    referencelist.update(current => current + (content,))
  }
}
#let references(header: "References") = {
  locate(
    loc => {
      let referencelist = referencelist.final(loc)
      if referencelist.len() > 0 {
        heading(level: 2, text(header))
        line(length: 100%, stroke: 1pt + black)
        referencelist.join()
      }
    }
  )
}