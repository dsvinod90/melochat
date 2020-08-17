import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { LineChart, PieChart } from 'react-chartkick'
import 'chart.js'
import {Spring, config} from 'react-spring/renderprops'

class CountryCovidData extends React.Component {
  constructor(props) {
    super(props);
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleFormChange = this.handleFormChange.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
        confirmedCases: null,
        deathCases: null,
        recoveredCases: null,
        activeCases: null,
        date: null,
        isVisible: false,
        hasErrored: false
    }
  }

  handleFormChange(e) {
      this.handleFormSubmit(e.target.value)
  }

  handleFormSubmit(country) {
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

  onSuccessApi(obj) {
    this.setState(
        {
            activeCases: obj['Active'],
            deathCases: obj['Deaths'],
            recoveredCases: obj['Recovered'],
            confirmedCases: obj['Confirmed'],
            date: obj['Date'],
            isVisible: true,
            hasErrored: false
        }
    )
  }

  renderFailureResponse() {
      return(
        <div>
            <p>Covid data temporarily not available. Please refresh in sometime.</p>
        </div>
      )
  }

  renderSuccessResponse(dataVisible) {
    if (dataVisible){
        return(
            <div>
                <table className='table table-sm font-weight-bold'>
                    <tbody>
                      <tr className='text-info'>
                            <td> Confirmed Cases </td>
                            <td>
                                <Spring
                                    from={{ number: this.state.confirmedCases - 1000 }}
                                    to={{ number: this.state.confirmedCases }}
                                    config={{ tension: 280, friction: 120, duration: 200, delay: 400 }}>
                                    {props => <div>{props.number}</div>}
                                </Spring>
                            </td>
                        </tr>
                      <tr className='text-danger'>
                            <td> Deaths </td>
                            <td>
                                <Spring
                                    from={{ number: this.state.deathCases - 1000 }}
                                    to={{ number: this.state.deathCases }}
                                    config={{ tension: 280, friction: 120, duration: 200, delay: 400 }}>
                                    {props => <div>{props.number}</div>}
                                </Spring>
                            </td>
                        </tr>
                        <tr className='text-success'>
                            <td> Recovered </td>
                            <td>
                                <Spring
                                    from={{ number: this.state.recoveredCases - 1000 }}
                                    to={{ number: this.state.recoveredCases }}
                                    config={{ tension: 280, friction: 120, duration: 200, delay: 400 }}>
                                    {props => <div>{props.number}</div>}
                                </Spring>
                            </td>
                        </tr>
                        <tr className='text-primary'>
                            <td> Active </td>
                            <td>
                                <Spring
                                    from={{ number: this.state.activeCases - 1000 }}
                                    to={{ number: this.state.activeCases }}
                                    config={{ tension: 280, friction: 120, duration: 200, delay: 400 }}>
                                    {props => <div>{props.number}</div>}
                                </Spring>
                            </td>
                        </tr>
                        <tr>
                            <td> Date of Record </td>
                            <td>{this.state.date}</td>
                        </tr>
                    </tbody>
                </table>
                <PieChart data={[["Active", this.state.activeCases], ["Recovered", this.state.recoveredCases], ["Deaths", this.state.deathCases]]} colors={["blue", "green", "red"]} />
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

  onFailureApi(error) {
      console.log(error);
      this.setState(
          {
              hasErrored: true
          }
      )
  }

  render() {
    let sortedCountries = this.props.countries.map((list, index) => <option key={index+1} value={list['slug']}>{list['name']}</option>);
    let summaryUrl = this.props.countrySummaryUrl;
    const isDataVisible = this.state.isVisible;
    const hasApiErrored = this.state.hasErrored;
    let covidData;
    if (!hasApiErrored){
        covidData = this.renderSuccessResponse(isDataVisible);
    } else {
        covidData = this.renderFailureResponse();
    }
    return(
        <div>
            <form className="text-center">
              <div className="input-group mb-3">
                <div className="input-group-prepend">
                  <label className="input-group-text" htmlFor="inputGroupCountryCovid">Countries</label>
                </div>
                <select className="custom-select" name="country" id="inputGroupCountryCovid" onChange={(e) => this.handleFormChange(e)}>
                    <option key='0' value='' defaultValue="selected">Select Country</option>
                    {sortedCountries}
                </select>
              </div>
            </form>
            {covidData}
        </div>
    )
  }
}
export default CountryCovidData;
