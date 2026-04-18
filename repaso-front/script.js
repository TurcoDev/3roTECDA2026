






import { chargeCards } from "./chargeCards.mjs";
import { createHome } from "./home.mjs";





const cardContainer = document.getElementById("cards");

// Version arrow function
document.getElementById("home").addEventListener("click", () => {
  cardContainer.innerHTML = "";
  createHome();
});

document.getElementById("products").addEventListener("click", chargeCards);


