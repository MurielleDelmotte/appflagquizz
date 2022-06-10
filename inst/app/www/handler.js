$( document ).ready(function() {
  Shiny.addCustomMessageHandler('confetti', function(arg) {
     confetti({
        particleCount: 100,
        spread: 70,
        origin: { y: 0.6 }
    });
  })
});
