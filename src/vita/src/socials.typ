#let socialslist = state("socialslist", ())

#let social(
  name, icon: none,
) = {
  let social = if icon == none {
    name
  } else {
    box(icon, baseline: 20%)
    h(1em)
    name
  }

  socialslist.update(current => current + (social,))
}

#let socials(header: "Social Media") = {
  locate(
    loc => {
      let socialslist = socialslist.final(loc)
      if socialslist.len() > 0 {
        heading(level: 1, header)
        block(
          align(left)[#socialslist.join("\n")]
        )
      }
    }
  )
}
