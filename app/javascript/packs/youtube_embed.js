document.addEventListener("DOMContentLoaded",
        function() {
            var div, n,
                v = document.querySelectorAll(".youtube-player");

            v.forEach(vid => {
              const div = document.createElement('div')
                div.setAttribute("data-id", vid.dataset.id);
                div.innerHTML = labnolThumb(vid.dataset.id);
                div.addEventListener('click',labnolIframe);
                vid.appendChild(div);
                console.log(vid)
            })
        });

    function labnolThumb(id) {
        var thumb = '<img src="https://i.ytimg.com/vi/ID/hqdefault.jpg">',
            play = '<div class="play"></div>';
        return thumb.replace("ID", id) + play;
    }

    function labnolIframe() {
      console.log(this)
        var iframe = document.createElement("iframe");
        var embed = "https://www.youtube.com/embed/ID?autoplay=1";
        iframe.setAttribute("src", embed.replace("ID", this.dataset.id));
        iframe.setAttribute("frameborder", "0");
        iframe.setAttribute("allowfullscreen", "1");
        this.parentNode.replaceChild(iframe, this);
    }
