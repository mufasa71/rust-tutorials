use crate::crawlers::{Credit, text_helpers::clean_text};
use scraper::{Html, Selector};

const URL: &str = "https://aab.uz/ru/private/crediting/";

pub async fn asia_alliance_parser(url: Option<&str>) -> Result<Vec<Credit>, Box<dyn std::error::Error>> {
    let url = url.unwrap_or(URL);
    let html = reqwest::get(url)
        .await?
        .text()
        .await?;

    let document = Html::parse_document(&html);
    let credit_selector = Selector::parse(".element--crediting").unwrap();
    let title_selector = Selector::parse(".element__title").unwrap();
    let params_selector = Selector::parse(".element__params .element__param").unwrap();
    let mut credits: Vec<Credit> = vec![];

    for element in document.select(&credit_selector) {
        let mut credit = Credit {
            title: String::new(),
            rate: String::new(),
            term: String::new(),
            sum: String::new(),
        };

        credit.title = clean_text(element.select(&title_selector).next().unwrap().text());

        element
            .select(&params_selector)
            .enumerate()
            .for_each(|(i, element)| {
                let value = clean_text(element.text());

                match i {
                    0 => credit.rate = value,
                    1 => credit.term = value,
                    2 => credit.sum = value,
                    _ => (),
                }
            });

        credits.push(credit);
    }

    Ok(credits)
}
