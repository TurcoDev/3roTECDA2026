function createHome() {
  const homeElement = document.createElement("h2");
  homeElement.textContent = "Welcome to the Home Page!";
  cardContainer.appendChild(homeElement);
  const descriptionElement = document.createElement("p");
  descriptionElement.textContent = "Click on the Products tab to see our products.";
  cardContainer.appendChild(descriptionElement);
}

export { createHome };