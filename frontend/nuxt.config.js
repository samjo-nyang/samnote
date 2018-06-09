module.exports = {
  head: {
    title: 'SamNote',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Sam Note' },
    ],
  },
  loading: { color: '#3B8070' },
  css: [
    'element-ui/lib/theme-chalk/index.css',
  ],
  plugins: [
    '@/plugins/element-ui',
  ],
  mode: 'spa',
  build: {
    extractCSS: true,
    extend(config, { isDev, isClient }) {
      if (!config.module.loaders) {
        // eslint-disable-next-line
        config.module.loaders = [];
      }
      config.module.loaders.push({
        test: /\.s[a|c]ss$/,
        loader: 'style!css!sass',
      });
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/,
        });
      }
    },
  },
};
