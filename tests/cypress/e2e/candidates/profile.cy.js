describe('Test candidate profile page', () => {
    it("Open UF board", () => {
        cy.visit('/candidatos/');
        cy.get('.right a').click();

        cy.get('.candidate').each(candidate => {
            cy.wrap(candidate)
                .should('have.attr', 'href');
        })
    })
});
