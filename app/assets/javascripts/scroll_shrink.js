// window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
    document.getElementById("logo-img-top").style.display = "none";
    // document.getElementById("teams-submit").style.width = "10px";
    // document.getElementById("teams-submit").innerText('<i class="fas fa-basketball-ball"></i>');


  } else {
    document.getElementById("logo-img-top").style.marginBottom = "46px";
  }
}
