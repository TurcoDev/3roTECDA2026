
import { cards } from "./data.mjs";

const cardContainer = document.getElementById("cards");

let currentData = null;
fetch("https://servicodados.ibge.gov.br/api/v1/produtos/estatisticas")
  .then(response => response.json())
  .then(data => {
    console.log(data);
    currentData = data;
  })


export function chargeCards() {
  cardContainer.innerHTML = "";
  currentData.forEach(card => {
    createCard(card);
  });
}



function createCard(card) {
  const cardElement = document.createElement("div");
  cardElement.classList.add("card");

  // const imageElement = document.createElement("img");
  // imageElement.src = card.image;
  // imageElement.alt = card.title;

  const titleElement = document.createElement("h2");
  titleElement.textContent = card.titulo;

  const descriptionElement = document.createElement("p");
  descriptionElement.textContent = card.alias;

  // cardElement.appendChild(imageElement);
  cardElement.appendChild(titleElement);
  cardElement.appendChild(descriptionElement);

  cardContainer.appendChild(cardElement);

}

// Otra forma de hacerlo es usando innerHTML, pero no es tan recomendable porque puede ser menos seguro y más difícil de mantener. Sin embargo, aquí tienes un ejemplo de cómo hacerlo con innerHTML:

/*
cards.forEach(card => {
  cardContainer.innerHTML += `
    <div class="card">
      <img src="${card.image}" alt="${card.title}" />
      <h2>${card.title}</h2>
      <p>${card.description}</p>
    </div>
  `;
});
*/
