describe('Test senators and deputies', () => {
    it('Select "Senadores" and "Deputados"', () => {
        cy.visit('/candidatos/');
        cy.get('.right a').click();
        
        cy.get('#deputies').click();
        cy.wait(600);
        cy.get('.candidate__info').each(info => {
            cy.wrap(info)
                .invoke('text')
                .should('contain', 'Senador(a)');
        });

        cy.get('#deputies').click();
        cy.get('#senators').click();
        cy.wait(600);
        cy.get('.candidate__info').each(info => {
            cy.wrap(info)
                .invoke('text')
                .should('contain', 'Deputado(a)');
        });
    })
})