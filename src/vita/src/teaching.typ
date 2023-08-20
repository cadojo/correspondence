#let teachinglist = state("teachinglist", ())

#let teaching(
  organization,
  role: none,
  start: none,
  stop: none, 

  notes
) = {
  let content = [
    #grid(
      columns: (65%, 33%, 1fr),
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

  teachinglist.update(current => current + (content,))
}
#let teachings(header: "Teaching Experience") = {
  locate(
    loc => {
      let teachinglist = teachinglist.final(loc)
      if teachinglist.len() > 0 {
        heading(level: 2, text(header))
        line(length: 100%, stroke: 1pt + black)
        teachinglist.join()
      }
    }
  )
}