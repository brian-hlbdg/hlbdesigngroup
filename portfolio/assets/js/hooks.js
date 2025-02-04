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
        this.el.textContent = now.toLocaleDateString('en-US', options) + " San Francisco, CA";
      }, 1000);
    },
    destroyed() {
      clearInterval(this.timer);
    }
  },
  
  TypeWriter: {
    mounted() {
      const text = this.el.textContent.trim();
      this.el.textContent = '';
      this.el.classList.add('typed-text');
      
      const type = (i = 0) => {
        if (i < text.length) {
          requestAnimationFrame(() => {
            this.el.textContent += text.charAt(i);
            if (i === 0) this.el.classList.add('visible');
            type(i + 1);
          });
        }
      };

      // Start typing after initial animations
      setTimeout(() => type(), 2000);
    }
  }
};

export default Hooks;