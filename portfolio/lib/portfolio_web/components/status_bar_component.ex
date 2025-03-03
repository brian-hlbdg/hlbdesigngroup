# lib/portfolio_web/components/status_bar_component.ex
defmodule PortfolioWeb.Components.StatusBarComponent do
  use PortfolioWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="status-bar">
      <div class="time-location">
        <span id="datetime" phx-hook="UpdateTime">
          <%= Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y %I:%M:%S %p") %>
        </span>
        <span id="location">Chicago, IL</span>
      </div>
      <div class="name-location">
        <span class="name">Brian H.</span>
        <span id="mobile-location">Chicago, IL</span>
        <button class="menu-button" phx-click="toggle_menu" phx-target={@myself}>Menu</button>
      </div>
    </div>
    """
  end

  def handle_event("toggle_menu", _, socket) do
    send(self(), :toggle_menu)
    {:noreply, socket}
  end
end

# lib/portfolio_web/components/menu_overlay_component.ex
defmodule PortfolioWeb.Components.MenuOverlayComponent do
  use PortfolioWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class={["menu-overlay", @show_menu && "active"]}>
      <button class="close-menu" phx-click="toggle_menu" phx-target={@myself}>Close</button>
      <nav class="nav-links">
        <.link href="#work" phx-click="toggle_menu" phx-target={@myself}>View Work</.link>
        <.link href="#process" phx-click="toggle_menu" phx-target={@myself}>My Process</.link>
        <.link href="#contact" phx-click="toggle_menu" phx-target={@myself}>Get in Touch</.link>
        <.link href="#about" phx-click="toggle_menu" phx-target={@myself}>About Me</.link>
      </nav>
    </div>
    """
  end

  def handle_event("toggle_menu", _, socket) do
    send(self(), :toggle_menu)
    {:noreply, socket}
  end
end

# lib/portfolio_web/components/intro_content_component.ex
defmodule PortfolioWeb.Components.IntroContentComponent do
  use PortfolioWeb, :live_component

  def render(assigns) do
    ~H"""
    <section class="intro-section">
      <div class="intro-content">
        <h1 class="animate-typing" id="main-heading" phx-hook="TypeWriter">
          I help companies build exceptional digital experiences through thoughtful design.
        </h1>
        <p class="animate-fade-in">
          UX Designer and Front-end Developer focused on creating intuitive,
          user-centered solutions that drive business growth.
        </p>
      </div>
    </section>
    """
  end
end
