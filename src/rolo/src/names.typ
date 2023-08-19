#let name(
    given: none,
    family: none,
    literal: none,
    dropping-particle: none,
    non-dropping-particle: none,
) = (
    given: given,
    family: family,
    literal: literal,
    dropping-particle: dropping-particle,
    non-dropping-particle: non-dropping-particle,
)


#let fullname(name) = {
    if name == none {
        none
    } else if type(name) == "string" {
        name
    } else {
        if name.literal != none {
            name.literal
        } else {
            (name.given, name.family).filter(v => v != none).join(" ")
        }
    }
}

#let nickname(name) = {
    if name == none {
        none
    } else {
        if type(name) == "string" {
            name
        }
        else if name.literal != none {
            name.literal.split().at(0)
        } else {
            name.given
        }
    }
}