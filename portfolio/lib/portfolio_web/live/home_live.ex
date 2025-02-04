# lib/portfolio_web/live/home_live.ex
defmodule PortfolioWeb.HomeLive do
  use PortfolioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      page_title: "Portfolio",
      show_menu: false
    )}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen">
      <div class="status-bar">
        <span id="time-display" phx-hook="UpdateTime">
          <%= Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p") %>
          San Francisco, CA
        </span>
        <span>
          Your Name
          <span class="hidden sm:inline-block">San Francisco, CA</span>
        </span>
      </div>

      <main>
        <div class="main-container">
          <div class="content-area">
            <h1 class="main-heading" id="intro-heading" phx-hook="TypeWriter">
              I help companies build exceptional digital experiences through thoughtful design.
            </h1>
            <p class="sub-heading">
              UX Designer and Front-end Developer focused on creating intuitive,
              user-centered solutions that drive business growth.
            </p>
          </div>

          <nav class="nav-links">
            <.link href="#work">View Work</.link>
            <.link href="#process">My Process</.link>
            <.link href="#contact">Get in Touch</.link>
            <.link href="#about">About Me</.link>
          </nav>
        </div>
      </main>

      <%= if @show_menu do %>
        <div class="menu-overlay" id="mobile-menu">
          <nav class="nav-links">
            <.link href="#work" phx-click="toggle_menu">View Work</.link>
            <.link href="#process" phx-click="toggle_menu">My Process</.link>
            <.link href="#contact" phx-click="toggle_menu">Get in Touch</.link>
            <.link href="#about" phx-click="toggle_menu">About Me</.link>
          </nav>
        </div>
      <% end %>
    </div>
    """
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, show_menu: !socket.assigns.show_menu)}
  end
end
