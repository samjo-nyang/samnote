<template>
  <div id="home-wrap">
    <div
      id="header"
      :style="headerStyle">
      <div
        v-if="mode === 'day'"
        :style="sunStyle"
        class="sun"/>
      <div
        v-if="mode === 'night'"
        class="stars">
        <div
          v-for="(star, index) in stars"
          :key="index"
          :style="star.style"/>
      </div>
    </div>
    <div id="content">
      <div class="title">
        <h1>SAMNOTE <small>v20180513</small></h1>
      </div>
      <p class="copyright">Designed By Sam Jo</p>
    </div>
  </div>
</template>

<script>
import SunCalc from 'suncalc';
import grassUrl from '~/assets/home/grass.png';
import treeUrl from '~/assets/home/tree.png';
import STAR_SPEC from './index.star.js';

const HEADER_GRADIENT = {
  day: '#479fd9, #bbffff',
  dawn: '#ababff, #ffabab',
  night: '#040429, #257eb7',
};

const makeStar = (spec, windowWidth) => {
  const isMobile = windowWidth <= 679;
  const { location: locationMobile, size: sizeMobile } = spec.mobile;
  const location = isMobile && locationMobile ? locationMobile : spec.location;
  const size = isMobile && sizeMobile ? sizeMobile : spec.size;
  return {
    spec,
    style: {
      ...location,
      background: `radial-gradient(circle, white 0%, white ${size[0]}, ${spec.color} ${size[1]}, transparent ${size[2]}) no-repeat`,
      'animation-duration': spec.interval,
      'animation-delay': `${Math.random() * 5}s`,
      'animation-iteration-count': 'infinite',
    },
  };
};

export default {
  layout: 'home',
  data() {
    return {
      mode: 'dawn',
      windowWidth: 0,
      headerStyle: {
        'background-image': '#000000',
      },
      sunStyle: {
        top: '0px',
        left: '0px',
      },
      stars: STAR_SPEC.map(x => makeStar(x, 0)),
    };
  },
  watch: {
    windowWidth() {
      this.update();
    },
  },
  mounted() {
    this.windowWidth = window.innerWidth;
    this.$nextTick(() => {
      window.addEventListener('resize', () => {
        this.windowWidth = window.innerWidth;
      });
    });
    this.update();
  },
  methods: {
    update() {
      const date = new Date();
      const now = this.toHours(date);

      const sunData = SunCalc.getTimes(date, 37.39, 127.12);
      const sunrise = this.toHours(sunData.sunriseEnd);
      const sunset = this.toHours(sunData.sunsetStart);

      this.mode = 'dawn';
      if (now > sunset + 0.5 || now < sunrise - 0.5) {
        this.mode = 'night';
      } else if (now > sunrise + 0.5 && now < sunset - 0.5) {
        this.mode = 'day';
      }

      this.headerStyle['background-image'] = `url('${grassUrl}'), url('${treeUrl}'), linear-gradient(180deg, ${HEADER_GRADIENT[this.mode]})`;
      const width = this.windowWidth / 2;
      const theta = (now - sunrise - 0.5) / (sunset - sunrise - 1) * Math.PI;
      this.sunStyle.top = `${280 - 280 * Math.sin(theta)}px`;
      this.sunStyle.left = `${width - (width * 0.72) * Math.cos(theta) - 90}px`;

      this.stars = STAR_SPEC.map(x => makeStar(x, this.windowWidth));
    },
    toHours(date) {
      return date.getHours()
        + date.getMinutes() / 60
        + date.getSeconds() / 3600;
    },
  },
};
</script>

<style lang="scss" scoped>
#home-wrap {
  background: black;
  color: white;
  min-height: 100%;
}

#header {
  height: 480px;
  text-align: center;
  background-position: left bottom, center bottom, left top, left bottom;
  background-repeat: repeat-x, no-repeat, no-repeat, no-repeat;
}

#content {
  padding: 0 20px;
}

.sun {
  background: radial-gradient(circle, white 0px, white 30px, rgba(253,255,219,0.2) 40px, transparent 60px) no-repeat;
  width: 140px;
  height: 140px;
  position: absolute;
}

.stars > div {
  width: 100px;
  height: 100px;
  position: absolute;
  animation-name: starAnimation;
}

.title {
  text-align: center;
  h1 {
    margin-top: -1rem;
    font-size: 3rem;
  }
  small {
    font-size: 40%;
  }
}

.copyright {
  color: #aaa;
  text-align: right;
}

@keyframes starAnimation {
  0%   { opacity: 1; }
  50%  { opacity: .7; }
  100% { opacity: 1; }
}

@media(max-width:679px) {
  #header {
    height: 380px;
  }
  .sun {
    background: radial-gradient(circle, white 0px, white 20px, rgba(253,255,219,0.2) 30px, transparent 50px) no-repeat;
    width: 120px; height: 120px;
    top: 10px !important;
    left: 10px !important;
  }
  .stars > div {
    width: 80px;
    height: 80px;
  }
  .title h1 {
    font-size: 2.5rem;
  }
}
</style>
