import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initAutocomplete } from "../plugins/init_autocomplete";

initAutocomplete();

import { getTimeRemaining, initializeClock } from './countdown';

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();

import { btnListener } from './share'

btnListener();

import { autocompleteAddress } from './get_current_location';

autocompleteAddress();

import "../plugins/flatpickr"


