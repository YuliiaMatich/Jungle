/// <reference types="cypress" />
describe('Jungle app', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  it("Homepage click", () => {
    cy.get('article:first').click().should("be.visible")
    cy.get('section').should('have.class', 'products-show')
  });
})