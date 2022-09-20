describe('Test parties filter', () => {
    it("Open Party board", () => {
        cy.visit('/candidatos/');
        cy.get('.right a').click();
        cy.get('#party .input-board__content label')
            .each(partyBtn => {
                cy.get('#party > button').click();
                cy.wrap(partyBtn)
                    .click()
                    .invoke('text')
                    .then(party => {
                        party = party.trim().replaceAll('\n', '');
                        cy.wait(600);
                        cy.get('.candidate__info').each(info => {
                            cy.wrap(info)
                                .invoke('text')
                                .should('contain', party);
                        })
                    })
                cy.get('#party > button').click(); 
                cy.wrap(partyBtn).click();
            })
    })
});