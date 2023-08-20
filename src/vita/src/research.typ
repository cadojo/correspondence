#let researchlist = state("researchlist", ())

#let research(
  organization,
  role: none,
  start: none,
  stop: none, 
  notes
) = {
  let content = [
    #grid(
      columns: (1fr, 1fr),
      heading(level: 3, organization),
      align(right)[
        #set text(rgb(90,90,90))
        #start #if stop != none { " — " + stop}
      ]
    )
    #if role != none {
      set text(rgb(90,90,90))
      if type(role) == "string" {
        v(-0.5em)
        text(role)
      } else {
        v(-0.5em)
        text(role.join(", "))
      }
    }
    #notes
  ]

  researchlist.update(current => current + (content,))
}
#let researching(header: "Research Experience") = {
  locate(
    loc => {
      let researchlist = researchlist.final(loc)
      if researchlist.len() > 0 {
        heading(level: 2, text(header))
        line(length: 100%, stroke: 1pt + black)
        researchlist.join()
      }
    }
  )
}