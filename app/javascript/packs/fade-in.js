document.addEventListener('turbolinks:load', () => {
  $(function () {
    $(window).scroll(function () {
      const windowHeight = $(window).height();
      const scroll = $(window).scrollTop();

      $('.element').each(function () {
        const targetPosition = $(this).offset().top;
        if (scroll > targetPosition - windowHeight + 220) {
          $(this).addClass("is-fadein");
        }
      });
    });
  });
})
