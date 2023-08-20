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
    affiliation: affiliation(),
) = (
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
    affiliation: affiliation,
)

#let address(author) = {
    if some(author) {
        let state = (author.affiliation.region, author.affiliation.postal-code).filter(some).join(" ")
        let location = (author.affiliation.city, state).filter(some).join(", ")
        (author.affiliation.address, location, author.affiliation.country).filter(some)
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
    if some(author) {
        stack(
            dir: ttb,
            spacing: 0.65em,
            ..(
                text(weight: "semibold", fullname(author.name)),
                author.email,
                author.orcid,
                author.affiliation.department,
                author.affiliation.name,
            ).filter(some)
        )
    } else {
        none
    }
}
