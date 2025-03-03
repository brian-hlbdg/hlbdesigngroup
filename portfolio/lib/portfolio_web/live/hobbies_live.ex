# lib/portfolio_web/live/hobbies_live.ex
defmodule PortfolioWeb.HobbiesLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    hobby_categories = [
      %{
        id: "photography",
        title: "Photography",
        description: "Capturing moments and perspectives through the lens.",
        images: [
          %{
            url: "/images/hobbies/photography/photo1.jpg",
            alt: "Chicago skyline at sunset",
            caption: "Chicago skyline at sunset - captured from Adler Planetarium"
          },
          %{
            url: "/images/hobbies/photography/photo2.jpg",
            alt: "Autumn forest trail",
            caption: "Autumn colors at Starved Rock State Park"
          },
          %{
            url: "/images/hobbies/photography/photo3.jpg",
            alt: "Lake Michigan waves",
            caption: "Waves crashing on Lake Michigan during winter"
          },
          %{
            url: "/images/hobbies/photography/photo4.jpg",
            alt: "Downtown architecture detail",
            caption: "Architectural details in Chicago's Loop"
          }
        ]
      },
      %{
        id: "travel",
        title: "Travel",
        description: "Exploring new places, cultures, and experiences around the world.",
        images: [
          %{
            url: "/images/hobbies/travel/travel1.jpg",
            alt: "Tokyo street scene",
            caption: "Evening in Shibuya, Tokyo"
          },
          %{
            url: "/images/hobbies/travel/travel2.jpg",
            alt: "Mediterranean coast",
            caption: "Coastal village in Cinque Terre, Italy"
          },
          %{
            url: "/images/hobbies/travel/travel3.jpg",
            alt: "Mountain hiking trail",
            caption: "Hiking through the Swiss Alps near Interlaken"
          },
          %{
            url: "/images/hobbies/travel/travel4.jpg",
            alt: "Desert landscape",
            caption: "Sunrise at Joshua Tree National Park"
          }
        ]
      },
      %{
        id: "favorite-places",
        title: "Favorite Places",
        description: "Special locations that inspire and rejuvenate.",
        images: [
          %{
            url: "/images/hobbies/places/place1.jpg",
            alt: "Local coffee shop",
            caption: "My favorite corner at Intelligentsia Coffee"
          },
          %{
            url: "/images/hobbies/places/place2.jpg",
            alt: "Lakefront trail",
            caption: "Morning run along Chicago's lakefront trail"
          },
          %{
            url: "/images/hobbies/places/place3.jpg",
            alt: "Bookstore interior",
            caption: "Browsing at Myopic Books in Wicker Park"
          },
          %{
            url: "/images/hobbies/places/place4.jpg",
            alt: "Rooftop garden",
            caption: "Sunset from Cindy's rooftop at Chicago Athletic Association"
          }
        ]
      },
      %{
        id: "music",
        title: "Music & Concerts",
        description: "Live performances and musical discoveries that move me.",
        images: [
          %{
            url: "/images/hobbies/music/music1.jpg",
            alt: "Concert venue",
            caption: "Indie rock show at Metro Chicago"
          },
          %{
            url: "/images/hobbies/music/music2.jpg",
            alt: "Record collection",
            caption: "Part of my vinyl collection - mostly jazz and classic rock"
          },
          %{
            url: "/images/hobbies/music/music3.jpg",
            alt: "Jazz club",
            caption: "Late night at Green Mill Jazz Club"
          },
          %{
            url: "/images/hobbies/music/music4.jpg",
            alt: "Summer music festival",
            caption: "Catching a set at Pitchfork Music Festival"
          }
        ]
      }
    ]

    {:ok,
      socket
      |> mount_common("hobbies")
      |> assign(:page_title, "Hobbies & Interests")
      |> assign(:hobby_categories, hobby_categories)
      |> assign(:selected_category, hd(hobby_categories))
    }
  end

  def handle_event("select_category", %{"id" => category_id}, socket) do
    selected_category = Enum.find(socket.assigns.hobby_categories, &(&1.id == category_id))
    {:noreply, assign(socket, :selected_category, selected_category)}
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="hobbies-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8" phx-hook="FadeIn">
                Hobbies & Interests
              </h1>

              <p id="hobbies-intro" class="text-xl text-gray-600 max-w-prose mb-12" phx-hook="FadeIn">
                Beyond design and development, these are some of the things that inspire me and bring balance to my life.
                Exploring new places, capturing interesting perspectives, and finding beauty in everyday moments all
                contribute to my creative approach to design.
              </p>

              <div class="flex flex-wrap overflow-x-auto space-x-4 mb-10 pb-2">
                <%= for category <- @hobby_categories do %>
                  <button
                    phx-click="select_category"
                    phx-value-id={category.id}
                    class={"px-5 py-2 rounded-full text-sm font-medium transition-colors whitespace-nowrap " <>
                      if @selected_category.id == category.id,
                      do: "bg-[rgb(211,84,0)] text-white",
                      else: "bg-gray-100 text-gray-600 hover:bg-gray-200"}>
                    <%= category.title %>
                  </button>
                <% end %>
              </div>

              <div id="category-content" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-4"><%= @selected_category.title %></h2>
                <p class="text-gray-600 mb-8"><%= @selected_category.description %></p>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <%= for {image, i} <- Enum.with_index(@selected_category.images) do %>
                    <div id={"image-#{@selected_category.id}-#{i}"} class="overflow-hidden rounded-sm shadow-sm" phx-hook="ImageHover">
                      <img
                        src={image.url}
                        alt={image.alt}
                        class="w-full h-64 object-cover"
                      />
                      <div class="p-3 bg-gray-50">
                        <p class="text-sm text-gray-600"><%= image.caption %></p>
                      </div>
                    </div>
                  <% end %>
                </div>

                <div id="category-description" class="mt-12 pt-8 border-t border-gray-200">
                  <h3 class="text-xl font-medium mb-4">Why <%= String.downcase(@selected_category.title) %> matters to me</h3>
                  <p class="text-gray-600 mb-4">
                    <%= case @selected_category.id do %>
                      <% "photography" -> %>
                        Photography helps me slow down and appreciate the details that often go unnoticed in our fast-paced world.
                        It's taught me to observe more carefully and find beauty in unexpected places — skills that directly
                        influence my approach to design. Whether I'm shooting urban landscapes or intimate portraits, I'm always
                        looking for that perfect moment where light, composition, and subject come together.
                      <% "travel" -> %>
                        Travel broadens my perspective and challenges me to adapt to new environments and cultures. Each place I visit
                        offers unique design sensibilities, color palettes, and problem-solving approaches that enrich my creative
                        toolkit. I try to travel with an open mind and minimal plans, allowing for spontaneous discoveries and
                        authentic connections with the places and people I encounter.
                      <% "favorite-places" -> %>
                        Having special places to return to creates a sense of rootedness that balances my love for exploration.
                        These locations — whether a quiet café, a scenic trail, or a vibrant neighborhood — provide comfort and
                        inspiration in equal measure. I find that moving between familiar and unfamiliar environments keeps my
                        creativity fresh and helps me maintain perspective in my work.
                      <% "music" -> %>
                        Music is perhaps the most immediate way to shift my mood or focus. Live performances in particular offer
                        a connection to creativity in its most visceral form. As someone who spends much of my day in the visual
                        realm, I find that engaging with sound and rhythm exercises different parts of my brain and keeps my
                        creative thinking holistic and balanced.
                    <% end %>
                  </p>
                </div>
              </div>
            </div>
          </div>

          <.main_nav active={@active} />
        </div>
      </main>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end
end
