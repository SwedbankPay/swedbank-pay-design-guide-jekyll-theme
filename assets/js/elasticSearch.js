const size = 5

async function fetchData(page){
    const response = await fetch(`https://elk-node-search-proxy-stage.azurewebsites.net/search${window.location.search}&size=${size}&page=${page}`)
    const results = await response.json()
    
    return results
}

async function renderResults(page) {
    const query = window.location.search.substring(3).replace("+", " ")
    $(".title").html(`Results for "${query}"`)
    $(".search_results").html("Searching...")
    $(".search_pagination").last().html("")

    const results = await fetchData(page)

    if(results.total != 0){
        pagination(results.total, page)

        $(".total_results").html(`${results.total} results found`)
        $(".search_results").html("")

        results.hits.map(hit => {
            $(`<a href="${hit.url}" class="cards cards-primary">
                <div class="cards-content">
                    <small>${hit.url.substring(1).replace(".html", "")}</small>
                    <span class="h3 mt-3">${hit.title}</span>
                    <p class="m-0">${replaceTags(hit.highlight.text[0])}...</p>
                </div>
                <i class="material-icons">arrow_forward</i>
            </a>`).appendTo(".search_results")
        })
    }else{
        $(".search_results").html("No results")
    }
}

function pagination(totalResults, currentPage) {
    const totalPages = Math.ceil(totalResults/size)

    const previousPage = currentPage + 1 === 1 ? currentPage : currentPage - 1
    const disablePrevious = previousPage === currentPage ? "disabled" : ""
    
    const nextPage = currentPage + 1 === totalPages ? currentPage : currentPage + 1
    const disableNext = nextPage === currentPage ? "disabled" : ""

    $(".search_pagination").html("")
    
    $(".search_pagination").append(`
            <button onclick="renderResults(${previousPage}) ${disablePrevious}" type="button"
                    class="btn btn-primary btn-sm m-1"> < </button>
        `)

    for(let i = 0; i < totalPages; i++){
        $(`<button onclick="renderResults(${i})" type="button" 
                class="btn btn-primary btn-sm m-1 ${currentPage == i ? "current-page" : "" }">
                    ${i+1}
            </button>`).appendTo(".search_pagination")
    }

    $(`<button onclick="renderResults(${nextPage}) ${disableNext}" type="button" 
            class="btn btn-primary btn-sm m-1"> > </button>`).appendTo(".search_pagination")
}

function replaceTags(string) {
    return string.replace(/<em class="hlt1">/g, "<b>").replace(/<\/em>/g, "</b>")
}

renderResults(0)
