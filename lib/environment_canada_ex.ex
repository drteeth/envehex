defmodule EnvironmentCanada do
  import SweetXml

  defmodule Feed do
    defstruct(
      id: nil,
      title: nil,
      entries: []
    )
  end

  defmodule Entry do
    defstruct(
      id: nil,
      title: nil,
      link: nil,
      updated: nil,
      published: nil,
      category: nil,
      summary: nil
    )
  end

  def fetch(code) do
    HTTPoison.start
    response = HTTPoison.get!("http://weather.gc.ca/rss/city/#{code}.xml")

    # TODO check response.status_code
    body = response.body

    entries = body |> xpath(~x"//entry"l) |> Enum.map fn e ->
      %Entry{
        title:      e |> xpath(~x"title/text()"),
        id:         e |> xpath(~x"id/text()"),
        title:      e |> xpath(~x"title/text()"),
        link:       e |> xpath(~x"link/@href"),
        updated:    e |> xpath(~x"updated/text()"),
        published:  e |> xpath(~x"published/text()"),
        category:   e |> xpath(~x"category/@term"),
        summary:    e |> xpath(~x"summary/text()")
      }
    end

    %Feed{
      id: body |> xpath(~x"/feed/id/text()"),
      title: body |> xpath(~x"/feed/title/text()"),
      entries: entries
    }
  end

end
