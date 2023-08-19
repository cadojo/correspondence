#let affiliation(
    name: none,
    given: none,
    middle: none,
    family: none, 
    preferred: none,
    role: none,
    department: none,
    organization: none,
    street: none,
    city: none,
    region: none,
    postal: none,
    country: none,
) = (
    name: name,
    given: given,
    middle: middle,
    family: family,
    preferred: preferred,
    role: role,
    department: department,
    organization: organization,
    street: street,
    city: city,
    region: region,
    postal: postal,
    country: country,
)

#let contact(
    email: none,
    phone: none,
    website: none,
) = (
    email: email,
    phone: phone,
    website: website,
)

#let some(value) = value != none

#let address(affiliation) = (
    affiliation.street, 
    (affiliation.city, (affiliation.region, affiliation.postal).filter(some).join(" ")).filter(some).join(", "), 
    affiliation.country, 
).filter(some)

#let name(affiliation) = {
    if some(affiliation.preferred) {
        affiliation.preferred
    } else if some(affiliation.name) {
        affiliation.name
    } else if some(affiliation.given) or some(affiliation.family) {
        (affiliation.given, affiliation.middle, affiliation.family).filter(some).join(" ")
    } else {
        none
    }
}

#let fullname(affiliation) = {
    if some(affiliation.name) {
        affiliation.name
    } else if some(affiliation.given) or some(affiliation.family) {
        (affiliation.given, affiliation.middle, affiliation.family).filter(some).join(" ")
    } else {
        affiliation.preferred
    }
}