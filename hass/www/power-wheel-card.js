import {
  LitElement, html
} from 'https://unpkg.com/@polymer/lit-element@^0.5.2/lit-element.js?module';

class PowerWheelCard extends LitElement {
  static get properties() {
    return {
      hass: Object,
      config: Object,
    }
  };

  _generateClass(producingIsPositive, value) {
    if (producingIsPositive) {
      return value > 0 ? 'producing' : ((value < 0) ? 'consuming' : 'inactive');
    } else {
      return value > 0 ? 'consuming' : ((value < 0) ? 'producing' : 'inactive');
    }
  };

  _makePositionObject(hass, entity, configIcon, defaultIcon, decimals, producingIsPositive) {
    const stateObj = hass.states[entity];
    const stateStr = stateObj ? parseFloat(stateObj.state).toFixed(decimals) : 'unavailable';
    const icon = configIcon ? configIcon : (stateObj && stateObj.attributes.icon ? stateObj.attributes.icon : defaultIcon);
    const classValue = this._generateClass(producingIsPositive, stateObj && parseFloat(stateObj.state));
    const unit = stateObj && stateObj.attributes.unit_of_measurement ? stateObj.attributes.unit_of_measurement : 'unknown unit';

    return {
      stateObj,
      stateStr,
      icon,
      classValue,
      unit,
    };
  };

  _makeHomePositionObject(hass, data, entity, configIcon, defaultIcon, decimals) {
    let home = {};
    if (entity) { // home power value by sensor
      home = this._makePositionObject(hass, entity, configIcon, defaultIcon, decimals, false);
    } else { // home power value by calculation
      if (data.solar.stateObj && data.grid.stateObj) {
        home = {
          stateObj: {},
          stateStr: (parseFloat(data.solar.stateObj.state) + parseFloat(data.grid.stateObj.state)).toFixed(decimals),
          icon: configIcon ? configIcon : defaultIcon,
          classValue: this._generateClass(false, parseFloat(data.solar.stateObj.state) + parseFloat(data.grid.stateObj.state)),
          unit: data.solar.unit === data.grid.unit ? data.solar.unit : 'unknown unit',
        };
      } else {
        home = {
          stateObj: {},
          stateStr: 'unavailable',
          icon: configIcon ? configIcon : defaultIcon,
          classValue: 'inactive',
          unit: 'unknown unit',
        };
      }
    }
    return home;
  };

  _render({ hass, config }) {
    let data = {
      solar: {},
      grid: {},
      home: {},
    };
    let arrowData = {};

    if (config.view === 'energy' && this.energy_capable) {
      data.solar = this._makePositionObject(hass, config.solar_energy_entity, config.solar_icon,
          'mdi:weather-sunny', this.energy_decimals, true);
      data.grid = this._makePositionObject(hass, config.grid_energy_entity, config.grid_icon,
          'mdi:flash-circle', this.energy_decimals, false);
      data.home = this._makeHomePositionObject(hass, data, config.home_energy_entity, config.home_icon,
          'mdi:home', this.energy_decimals);
      arrowData = {
        solar2grid: {
          icon: 'mdi:arrow-bottom-left',
          classValue: 'inactive',
        },
        solar2home: {
          icon: 'mdi:arrow-bottom-right',
          classValue: 'inactive',
        },
        grid2home: {
          icon: 'mdi:arrow-right',
          classValue: 'inactive',
        },
      };
    } else {
      data.solar = this._makePositionObject(hass, config.solar_power_entity, config.solar_icon,
          'mdi:weather-sunny', this.power_decimals, true);
      data.grid = this._makePositionObject(hass, config.grid_power_entity, config.grid_icon,
          'mdi:flash-circle', this.power_decimals, false);
      data.home = this._makeHomePositionObject(hass, data, config.home_power_entity, config.home_icon,
          'mdi:home', this.power_decimals);
      arrowData = {
        solar2grid: {
          icon: 'mdi:arrow-bottom-left',
          classValue: data.grid.stateObj && parseFloat(data.grid.stateObj.state) < 0 ? 'active' : 'inactive',
        },
        solar2home: {
          icon: 'mdi:arrow-bottom-right',
          classValue: data.solar.stateObj && parseFloat(data.solar.stateObj.state) > 0
          && data.grid.stateObj && parseFloat(data.home.stateStr) != 0 ? 'active' : 'inactive',
        },
        grid2home: {
          icon: 'mdi:arrow-right',
          classValue: data.grid.stateObj && parseFloat(data.grid.stateObj.state) > 0
          && data.solar.stateObj && parseFloat(data.home.stateStr) != 0 ? 'active' : 'inactive',
        },
      };
    }

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
        ha-card .cell.position {
          cursor: pointer;
        }
        ha-icon {
          transition: color 0.5s ease-in-out, filter 0.3s ease-in-out;
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
        ha-icon.consuming {
          color: ${this.consumingColor};
        }
        ha-icon.producing {
          color: ${this.producingColor};
        }
        ha-icon#toggle-button {
          padding-top: 4px;
          width: 24px;
          height: 24px;
          float: right;
          cursor: pointer;
        }
      </style>
      <ha-card>
        ${this.energy_capable ? html`<ha-icon id="toggle-button" icon="mdi:recycle" on-click="${e => this._toggleView(e, config)}" title="Toggle view"></ha-icon>` : ''}
        <div class="header">
          ${this.title}
        </div>
        <div class="row">
          ${this._positionCell(data.solar)}
        </div>
        <div class="row">
          ${this._arrowCell(arrowData.solar2grid)}
          ${this._arrowCell(arrowData.solar2home)}
        </div>
        <div class="row">
          ${this._positionCell(data.grid)}
          ${this._arrowCell(arrowData.grid2home)}
          ${this._positionCell(data.home)}
        </div>
      </ha-card>
    `;
  }

  _positionCell(positionObj) {
    return html`
      <div class="cell position" on-click="${e => this._handleClick(e, positionObj.stateObj)}">
        <ha-icon class$="${positionObj.classValue}" icon="${positionObj.icon}"></ha-icon>
        <br/>${positionObj.stateStr} ${positionObj.unit}
      </div>
    `;
  };

  _arrowCell(arrowObj) {
    return html`
      <div class="cell">
        <ha-icon class$="${arrowObj.classValue}" icon="${arrowObj.icon}"></ha-icon>
        <div>&nbsp;${arrowObj.valueStr}&nbsp;</div>
      </div>
    `;
  };

  _handleClick(ev, stateObj) {
    if (!stateObj) {
      return;
    }
    const event = new Event('hass-more-info', {
      bubbles: true,
      cancelable: true,
      composed: true,
    });
    event.detail = { entityId: stateObj.entity_id };
    this.shadowRoot.dispatchEvent(event);
  }

  _toggleView(ev, config) {
    if (config.view === 'power') {
      config.view = 'energy';
    } else {
      config.view = 'power';
    }
  }

  setConfig(config) {
    if (!config.solar_power_entity) {
      throw new Error('You need to define a solar_power_entity');
    }
    if (!config.grid_power_entity) {
      throw new Error('You need to define a grid_power_entity');
    }
    this.title = config.title ? config.title : 'Power wheel';
    if (config.power_decimals && !Number.isInteger(config.power_decimals)) {
      throw new Error('Power_decimals should be an integer');
    }
    this.power_decimals = config.power_decimals ? config.power_decimals : 0;
    if (config.energy_decimals && !Number.isInteger(config.energy_decimals)) {
      throw new Error('Energy_decimals should be an integer');
    }
    this.energy_decimals = config.energy_decimals ? config.energy_decimals : 3;
    this.colorIcons = config.color_icons ? (config.color_icons == true) : false;
    this.consumingColor = this.colorIcons
      ? (config.consuming_color ? config.consuming_color : 'var(--label-badge-yellow, #f4b400)')
      : 'var(--state-icon-unavailable-color, #bdbdbd)';
    this.producingColor = this.colorIcons
      ? (config.producing_color ? config.producing_color : 'var(--label-badge-green, #0da035)')
      : 'var(--state-icon-unavailable-color, #bdbdbd)';
    if (config.initial_view && !['power', 'energy'].includes(config.initial_view)) {
      throw new Error("Initial_view should 'power' or 'energy'");
    }
    if (!config.view) {
      config.view = config.initial_view ? config.initial_view : 'power';
    }
    this.energy_capable = config.solar_energy_entity && config.grid_energy_entity;
    this.config = config;
  }

  getCardSize() {
    return 5;
  }
}

customElements.define('power-wheel-card', PowerWheelCard);
