# lib/portfolio_web/live/home_live.ex
defmodule PortfolioWeb.HomeLive do
  use PortfolioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      page_title: "Portfolio",
      show_menu: false,
      current_time: Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p")
    )}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white">
      <div class="fixed top-0 left-0 right-0 z-50 flex justify-between items-center py-3 px-8 bg-gray-50 border-b border-gray-100">
        <div class="flex gap-4">
          <span id="time-display" phx-hook="UpdateTime">
            <%= @current_time %> Chicago, IL
          </span>
        </div>
        <div class="flex gap-4 items-center">
          <span>Brian H.</span>
          <span class="hidden sm:inline-block">Chicago Bears Fan</span>
          <button class="hidden md:hidden bg-transparent border-0 cursor-pointer p-2 text-sm text-gray-600" phx-click="toggle_menu">
            Menu
          </button>
        </div>
      </div>

      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="main-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8" phx-hook="FadeIn">
                I help companies build exceptional digital experiences through thoughtful design.
              </h1>
              <p id="intro-text" class="text-xl md:text-2xl text-gray-600 max-w-prose mt-8" phx-hook="TypeWriter">
                UX Designer and Front-end Developer focused on creating intuitive,
                user-centered solutions that drive business growth.
              </p>
            </div>
          </div>

          <div class="w-full md:w-48 pt-12 md:pt-24">
            <nav id="main-nav" class="flex md:flex-col space-y-0 md:space-y-4 space-x-4 md:space-x-0 mt-8 md:mt-0" phx-hook="FadeIn">
              <.link href="#work" class="text-gray-600 text-sm hover:text-[rgb(211,84,0)] transition-colors">View Work</.link>
              <.link href="#process" class="text-gray-600 text-sm hover:text-[rgb(211,84,0)] transition-colors">My Process</.link>
              <.link href="#contact" class="text-gray-600 text-sm hover:text-[rgb(211,84,0)] transition-colors">Get in Touch</.link>
              <.link href="#about" class="text-gray-600 text-sm hover:text-[rgb(211,84,0)] transition-colors">About Me</.link>
            </nav>
          </div>
        </div>
      </main>

      <%= if @show_menu do %>
        <div class="fixed inset-0 bg-white z-50 mt-12 flex items-center justify-center">
          <button class="absolute top-8 right-8 text-gray-600 text-sm" phx-click="toggle_menu">
            Close
          </button>
          <nav class="flex flex-col items-center space-y-6">
            <.link href="#work" class="text-gray-600 text-xl" phx-click="toggle_menu">View Work</.link>
            <.link href="#process" class="text-gray-600 text-xl" phx-click="toggle_menu">My Process</.link>
            <.link href="#contact" class="text-gray-600 text-xl" phx-click="toggle_menu">Get in Touch</.link>
            <.link href="#about" class="text-gray-600 text-xl" phx-click="toggle_menu">About Me</.link>
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
