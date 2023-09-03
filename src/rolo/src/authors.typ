#import "names.typ": *
#import "attributes.typ": *
#import "affiliations.typ": *

#import "../../options/options.typ": some

#let author(
    number: none,
    name: name(),
    url: none,
    email: none,
    phone: none,
    fax: none,
    orcid: none,
    note: none,
    acknowledgements: none,
    attributes: attributes(),
    roles: none,
    metadata: none,
    affiliations: (affiliation(),),
) = {
    let affil = if type(affiliations) == "array" {affiliations} else {(affiliations,)}
    (
        number: number,
        name: name,
        url: url,
        email: email,
        phone: phone,
        fax: fax,
        orcid: orcid,
        note: note,
        acknowledgements: acknowledgements,
        attributes: attributes,
        roles: roles,
        metadata: metadata,
        affiliations: affil,
    )
}

#let address(author) = {
    let affil = author.affiliations.at(0)
    if some(author) {
        let state = (affil.region, affil.postal-code).filter(some).join(" ")
        let location = (affil.city, state).filter(some).join(", ")
        (affil.address, location, affil.country).filter(some)
    } else {
        none
    }
}

#let contact(author) = {
    if some(author) { 
        (
            author.phone,
            author.email,
            author.fax,
            author.url,
            author.orcid,
        ).filter(some)
    } else {
        none
    }
}

#let authorblock(author) = {
    let affil = author.affiliations.at(0)
    if some(author) {
        stack(
            dir: ttb,
            spacing: 0.65em,
            ..(
                text(weight: "semibold", fullname(author.name)),
                author.email,
                author.orcid,
                affil.department,
                affil.name,
            ).filter(some)
        )
    } else {
        none
    }
}
