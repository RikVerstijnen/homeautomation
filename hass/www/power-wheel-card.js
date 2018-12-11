import {
  LitElement, html
} from 'https://unpkg.com/@polymer/lit-element@^0.5.2/lit-element.js?module';

class PowerWheelCard extends LitElement {
  static get properties() {
    return {
      hass: Object,
      config: Object,
    }
  }

  _render({ hass, config }) {
    const title = config.title ? config.title : 'Power wheel';

    const solarPowerState = hass.states[config.solar_power_entity];
    const solarPowerStateStr = solarPowerState ? solarPowerState.state : 'unavailable';
    const solarPowerIcon = solarPowerState && solarPowerState.attributes.icon
      ? solarPowerState.attributes.icon : 'mdi:weather-sunny';

    const gridPowerState = hass.states[config.grid_power_entity];
    const gridPowerStateStr = gridPowerState ? gridPowerState.state : 'unavailable';
    const gridPowerIcon = gridPowerState && gridPowerState.attributes.icon
      ? gridPowerState.attributes.icon : 'mdi:flash-circle';

    const homePowerStateStr = solarPowerState && gridPowerState
      ? parseFloat(solarPowerState.state) + parseFloat(gridPowerState.state) : 'unavailable';
    const homePowerIcon = config.home_power_icon ? config.home_power_icon : 'mdi:home';

    const unitStr = solarPowerState && gridPowerState
      && solarPowerState.attributes.unit_of_measurement && gridPowerState.attributes.unit_of_measurement
      && solarPowerState.attributes.unit_of_measurement == gridPowerState.attributes.unit_of_measurement
      ? solarPowerState.attributes.unit_of_measurement : 'unknown unit';

    const solar2gridClass = gridPowerState && parseFloat(gridPowerState.state) < 0 ? 'active' : 'inactive';
    const solar2homeClass = solarPowerState && parseFloat(solarPowerState.state) > 0
      && gridPowerState && parseFloat(homePowerStateStr) != 0 ? 'active' : 'inactive';
    const grid2homeClass = gridPowerState && parseFloat(gridPowerState.state) > 0
      && solarPowerState && parseFloat(homePowerStateStr) != 0 ? 'active' : 'inactive';

    return html`
      <style>
        ha-card {
          padding: 16px;
        }
        ha-card .header {
          font-family: var(--paper-font-headline_-_font-family);
          -webkit-font-smoothing: var(--paper-font-headline_-_-webkit-font-smoothing);
          font-size: var(--paper-font-headline_-_font-size);
          font-weight: var(--paper-font-headline_-_font-weight);
          letter-spacing: var(--paper-font-headline_-_letter-spacing);
          line-height: var(--paper-font-headline_-_line-height);
          color: var(--primary-text-color);
          padding: 4px 0 12px;
          display: flex;
          justify-content: space-between;
        }
        ha-card .row {
          display: flex;
          justify-content: center;
          padding: 8px;
          align-items: center;
          height: 60px;
        }
        ha-card .cell {
          text-align: center;
          width: 150px;
        }
        ha-icon {
          transition: color 0.3s ease-in-out, filter 0.3s ease-in-out;
          color: var(--paper-item-icon-color, #44739e);
          width: 48px;
          height: 48px;
        }
        ha-icon.active {
          color: var(--paper-item-icon-active-color, #fdd835);
        }
        ha-icon.inactive {
          color: var(--state-icon-unavailable-color, #bdbdbd);
        }
      </style>
      <ha-card>
        <div class="header">
          ${title}
        </div>
        <div class="row">
          <div class="cell">
            <ha-icon icon="${solarPowerIcon}"></ha-icon>
            <br/>${solarPowerStateStr} ${unitStr}
          </div>
        </div>
        <div class="row">
          <div class="cell">
            <ha-icon class$="${solar2gridClass}" icon="mdi:arrow-bottom-left"></ha-icon>
          </div>
          <div class="cell">
            <ha-icon class$="${solar2homeClass}" icon="mdi:arrow-bottom-right"></ha-icon>
          </div>
        </div>
        <div class="row">
          <div class="cell">
            <ha-icon icon="${gridPowerIcon}"></ha-icon>
            <br/>${gridPowerStateStr} ${unitStr}
          </div>
          <div class="cell">
            <ha-icon class$="${grid2homeClass}" icon="mdi:arrow-right"></ha-icon>
          </div>
          <div class="cell">
            <ha-icon icon="${homePowerIcon}"></ha-icon>
            <br/>${homePowerStateStr} ${unitStr}
          </div>
        </div>
      </ha-card>
    `;
  }

  setConfig(config) {
    if (!config.solar_power_entity) {
      throw new Error('You need to define a solar_power_entity');
    }
    if (!config.grid_power_entity) {
      throw new Error('You need to define a grid_power_entity');
    }
    this.config = config;
  }

  getCardSize() {
    return 5;
  }
}

customElements.define('power-wheel-card', PowerWheelCard);