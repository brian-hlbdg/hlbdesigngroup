// assets/js/hooks.js
const Hooks = {
  UpdateTime: {
    mounted() {
      this.timer = setInterval(() => {
        const now = new Date();
        const options = { 
          weekday: 'long', 
          year: 'numeric', 
          month: 'long', 
          day: 'numeric',
          hour: '2-digit', 
          minute: '2-digit',
          second: '2-digit',
          hour12: true
        };
        this.el.textContent = now.toLocaleDateString('en-US', options) + " Chicago, IL";
      }, 1000);
    },
    destroyed() {
      clearInterval(this.timer);
    }
  },
  
  TypeWriter: {
    mounted() {
      const mainText = this.el.textContent.trim(); // Get text from the element
      this.el.textContent = ''; // Clear existing text
      let currentText = "";
      let currentIndex = 0;

      // Typing animation
      const typeText = () => {
        if (currentIndex < mainText.length) {
          currentText += mainText[currentIndex];
          this.el.textContent = currentText;
          currentIndex++;
          setTimeout(typeText, 50);
        } else {
          // Fade in navigation after typing is complete
          const navLinks = document.getElementById('main-nav');
          if (navLinks) {
            navLinks.style.opacity = "1";
            navLinks.style.transition = "opacity 1s ease";
          }
        }
      };

      // Start typing after a delay
      setTimeout(() => {
        this.el.style.opacity = "1";
        typeText();
      }, 2000);
    }
  },
  
  FadeIn: {
    mounted() {
      setTimeout(() => {
        this.el.style.opacity = "1";
        this.el.style.transition = "opacity 1s ease";
      }, this.el.id === 'intro-text' ? 1500 : 500);
    }
  }
};

export default Hooks;