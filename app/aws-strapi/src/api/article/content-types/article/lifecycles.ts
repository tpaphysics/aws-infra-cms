module.exports = {
  async beforeCreate(event: any) {
    let { data } = event.params;
    //console.log(data);
    // Contar o número de artigos existentes
    const count = await strapi.db.query("api::article.article").count({});
    //console.log(count);
    // Atribuir o valor count + 1 à propriedade articleNumber do novo artigo
    data.articleNumber = count + 1;
  },
};
