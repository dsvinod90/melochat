import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { LineChart, PieChart } from 'react-chartkick'
import 'chart.js'
import {Spring, config} from 'react-spring/renderprops'

class CountryCovidUpdate extends React.Component {
  constructor(props) {
    super(props);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleFormChange = this.handleFormChange.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.fetchChartData = this.fetchChartData.bind(this);
    this.onChartSuccessApi = this.onChartSuccessApi.bind(this);
    this.renderFailureChartResponse = this.renderFailureChartResponse.bind(this);
    this.renderSuccessChartResponse = this.renderSuccessChartResponse.bind(this);
    this.onChartFailureApi = this.onChartFailureApi.bind(this);
    this.state = {
        confirmedCases: null,
        deathCases: null,
        recoveredCases: null,
        activeCases: null,
        country: null,
        date: null,
        allStatus: null,
        isVisible: false,
        isChartVisible: false,
        hasChartErrored: false,
        hasErrored: false,
        countrySlug: null
    }
  }

  handleFormChange(e) {
      this.handleFormSubmit(e.target.value)
  }

  handleFormSubmit(country) {
      this.setState(
          {
              countrySlug: country
          }
      )
    fetch(this.props.countrySummaryUrl + `?country=${country}`, {
        method: 'GET',
        headers: {'Content-Type': 'application/json',Accept: 'application/json' }
    })
    .then(
      response => {
        if (response.status >= 200 && response.status <= 299) {
          return response.json();
        } else {
          throw Error(response.statusText);
        }
      }
    )
    .then(data => { this.onSuccessApi(data); })
    .catch(error => { this.onFailureApi(error); })
  }

  fetchChartData(allStatusObj) {
    fetch(this.props.dateWiseSummaryUrl + `?country=${this.state.countrySlug}`, {
        method: 'GET',
        headers: {'Content-Type': 'application/json',Accept: 'application/json' }
    })
    .then(
      response => {
        if (response.status >= 200 && response.status <= 299) {
          return response.json();
        } else {
          throw Error(response.statusText);
        }
      }
    )
    .then(data => { this.onChartSuccessApi(data); })
    .catch(error => { this.onChartFailureApi(error); })
  }

  onChartSuccessApi(obj) {
      this.setState(
          {
            allStatus: obj,
            hasChartErrored: false,
            isChartVisible: true
          }
      )
  }

  onSuccessApi(obj) {
    this.setState(
        {
            activeCases: obj['Active'],
            deathCases: obj['Deaths'],
            recoveredCases: obj['Recovered'],
            confirmedCases: obj['Confirmed'],
            country: obj['Country'],
            date: obj['Date'],
            isVisible: true,
            hasErrored: false
        }
    )
    this.fetchChartData(this.state.countrySlug);
  }

  renderFailureResponse() {
      return(
        <div>
            <p>Covid data temporarily not available. Please refresh in sometime.</p>
        </div>
      )
  }

  renderFailureChartResponse() {
      return(
        <div>
            <p>Chart temporarily not available. Please refresh in sometime.</p>
        </div>
      )
  }

  renderSuccessResponse(dataVisible) {
    if (dataVisible){
        return(
            <div>
                <h3 className='covid-heading text-center'> {this.state.country} </h3>
                <div className='row'>
                    <div className='col-6'>
                        <div className='row justify-content-center'>
                            <h3 className='text-secondary countries-list text-center'><b> Active </b></h3>
                        </div>
                        <div className='row justify-content-center'>
                            <h3 className='text-primary countries-list text-center'>
                                <b>
                                    <Spring
                                        from={{ number: this.state.activeCases - 1000 }}
                                        to={{ number: this.state.activeCases }}
                                        config={{ tension: 280, friction: 120, duration: 200, delay: 1000 }}>
                                        {props => <div>{props.number}</div>}
                                    </Spring>
                                </b>
                            </h3>
                        </div>
                        <div className='row justify-content-center card-details'>
                            <h3 className='text-secondary countries-list text-center'><b> Deaths </b></h3>
                        </div>
                        <div className='row justify-content-center'>
                            <h3 className='text-danger countries-list text-center'>
                                <b>
                                    <Spring
                                        from={{ number: this.state.deathCases - 1000 }}
                                        to={{ number: this.state.deathCases }}
                                        config={{ tension: 280, friction: 120, duration: 200, delay: 1000 }}>
                                        {props => <div>{props.number}</div>}
                                    </Spring>
                                </b>
                            </h3>
                        </div>
                    </div>
                    <div className='col-6'>
                        <div className='row justify-content-center'>
                            <h3 className='text-secondary countries-list text-center'><b> Confirmed </b></h3>
                        </div>
                        <div className='row justify-content-center'>
                            <h3 className='countries-list text-center text-warning'>
                                <b>
                                    <Spring
                                        from={{ number: this.state.confirmedCases - 1000 }}
                                        to={{ number: this.state.confirmedCases }}
                                        config={{ tension: 280, friction: 120, duration: 200, delay: 1000 }}>
                                        {props => <div>{props.number}</div>}
                                    </Spring>
                                </b>
                            </h3>
                        </div>
                        <div className='row justify-content-center card-details'>
                            <h3 className='text-secondary countries-list text-center'><b> Recovered </b></h3>
                        </div>
                        <div className='row justify-content-center'>
                            <h3 className='text-success countries-list text-center'>
                                <b>
                                    <Spring
                                        from={{ number: this.state.recoveredCases - 1000 }}
                                        to={{ number: this.state.recoveredCases }}
                                        config={{ tension: 280, friction: 120, duration: 200, delay: 1000 }}>
                                        {props => <div>{props.number}</div>}
                                    </Spring>
                                </b>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        )
    } else {
        return(
            <div>
                <p>Select a country to see the covid updates of that country.</p>
            </div>
        )
    }
  }

  renderSuccessChartResponse(dataVisible) {
      if(dataVisible){
          return(
            <div>
                <h2 className='covid-heading text-center'> Cummulative weekly statistics </h2>
                <div className='blog-content'>
                    <LineChart data={this.state.allStatus} width="1000px" height="400px"/>
                </div>  
            </div>
          )
      }
  }

  onFailureApi(error) {
      console.log(error);
      this.setState(
          {
              hasErrored: true
          }
      )
  }

  onChartFailureApi(error) {
      console.log(error);
      this.setState(
          {
              hasChartErrored: true
          }
      )
  }

  render() {
    let sortedCountries = this.props.countries.map((list, index) => <option key={index+1} value={list['slug']}>{list['name']}</option>);
    let summaryUrl = this.props.countrySummaryUrl;
    const isDataVisible = this.state.isVisible;
    const isChartDataVisible = this.state.isChartVisible;
    const hasApiErrored = this.state.hasErrored;
    const hasChartApiErrored = this.state.hasChartErrored;
    let covidData;
    let chartData;
    if (!hasApiErrored){
        covidData = this.renderSuccessResponse(isDataVisible);
    } else {
        covidData = this.renderFailureResponse();
    }
    if(!hasChartApiErrored){
        chartData = this.renderSuccessChartResponse(isChartDataVisible);
    } else {
        chartData = this.renderFailureChartResponse();
    }
    return(
        <div>
            <form className="text-center">
                <select name="country" id="country-select" onChange={(e) => this.handleFormChange(e)}>
                    <option key='0' value='' defaultValue="selected">Select Country</option>
                    {sortedCountries}
                </select>
            </form>
            {covidData}
            {chartData}
        </div>
    )
  }
}
export default CountryCovidUpdate;