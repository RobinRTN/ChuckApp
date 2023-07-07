import { Controller } from "@hotwired/stimulus"
import introJs from 'intro.js'

export default class extends Controller {
  connect() {
    this.intro = introJs()
    this.intro.setOptions({
      nextLabel: 'Suivant',
      prevLabel: 'Précédent',
      doneLabel: 'Fini',
      steps: this.getSteps()
    });
  }

  start() {
    this.intro.start()
    this.finishOnboarding();
  }

  finishOnboarding() {
    console.log("FINISSHHIINNG")
    fetch("/users/finish_onboarding", {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      credentials: "same-origin",
    });
  }

  getSteps() {
    const isMobile = window.innerWidth <= 768; // Change this value as needed
    const appendId = isMobile ? '-mobile' : '';

    return [
      {
        intro: "Bienvenue sur ChuckApp 🥳 Prêt(e) pour une petite exploration guidée de ton nouvel outil préféré ?"
      },
      {
        element: document.querySelector(`#share-link-demo${appendId}`),
        intro: "Voici ta page personnalisée ! Un espace unique que tu peux partager sur tes réseaux sociaux ou via ton propre QR Code ! 🌐"
      },
      {
        element: document.querySelector(`#profile-link-demo${appendId}`),
        intro: "Ici, tu peux ajouter ta touche personnelle ! Change tes photos, ajuste tes prestations et définis tes disponibilités de la semaine en un clin d'œil. 📸"
      },
      {
        element: document.querySelector('#mois-demo'),
        intro: "Garde un œil sur le mois en cours avec ces informations clés : revenus, calendrier, prochaines réservations. C'est ton tableau de bord personnel. 📊"
      },
      {
        element: document.querySelector(`#contacts-demo${appendId}`),
        intro: "C'est ton carnet d'adresses ! Ajoute manuellement tes clients ou laisse-les s'ajouter lorsqu'ils réservent. 📒"
      },
      {
        element: document.querySelector(`#resa-demo${appendId}`),
        intro: "Ici, tu trouveras un aperçu complet de toutes tes réservations : passées, futures et en attente. Un moyen simple de garder le contrôle. ⏳"
      },
      {
        element: document.querySelector(`#dispo-demo${appendId}`),
        intro: "Un rendez-vous chez le coiffeur à 17h ? Des vacances dans deux semaines ? Ajuste tes disponibilités en un clic. 🗓️"
      },
      {
        element: document.querySelector(`#presta-demo${appendId}`),
        intro: "Modifie tes prestations ici. Personnalise ton offre pour répondre parfaitement aux besoins de tes clients ! 👍"
      },
      {
        intro: "Si tu as le moindre souci, n'hésite pas à nous contacter. Bonne route vers le succès avec ChuckApp ! 🚀"
      },
    ];
  }
}
