#let skillslist = state("skillslist", ())

#let skill(
  name, notes,
) = {
  let title = [
    #heading(level: 3, name)
    #notes
  ]

  skillslist.update(current => current + (title,))
}
#let skills(header: "Technical Skills") = {
  locate(
    loc => {
      let skillslist = skillslist.final(loc)
      if skillslist.len() > 0 {
        heading(level: 2, header)
        line(length: 100%, stroke: 1pt + black)
        skillslist.join()
      }
    }
  )
}