/// <reference types="cypress" />
describe('Jungle app', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  it("Products on page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})
