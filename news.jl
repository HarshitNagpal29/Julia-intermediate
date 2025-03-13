using Pkg
Pkg.add("HTTP")
Pkg.add("JSON")
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Gumbo")
Pkg.add("Cascadia")
using HTTP, JSON, DataFrames, CSV, Gumbo, Cascadia

try
    global response = HTTP.get("https://www.bbc.com/news")
    println("HTTP request successful")
catch e
    println("HTTP request failed: $e")
    exit(1)
end

html = String(response.body)
parsed = Gumbo.parsehtml(html)

headlines = eachmatch(Selector("h2"), parsed.root)
filtered = [headline for headline in headlines if haskey(headline.attributes, "data-testid") && headline.attributes["data-testid"] == "card-headline"]
headlines = [strip(nodeText(headline)) for headline in filtered]
# headlines = [strip(nodeText(headline)) for headline in headlines]

df = DataFrame(Headline=headlines)  
CSV.write("headlines.csv", df)  