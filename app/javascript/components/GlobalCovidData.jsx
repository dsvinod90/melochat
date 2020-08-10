import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class GlobalCovidData extends React.Component {
  constructor(props) {
    super(props);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
        totalConfirmedCases: null,
        totalRecoveredCases: null,
        totalDeathCases: null,
        newConfirmedCases: null,
        newDeathCases: null,
        newRecoveredCases: null,
        isVisible: false,
        hasErrored: false
    }
  }

  renderGlobalSummary() {
    fetch(this.props.globalSummaryUrl, {
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
            totalConfirmedCases: obj['TotalConfirmed'],
            totalDeathCases: obj['TotalDeaths'],
            totalRecoveredCases: obj['TotalRecovered'],
            newConfirmedCases: obj['NewConfirmed'],
            newDeathCases: obj['NewDeaths'],
            newRecoveredCases: obj['NewRecovered'],
            isVisible: true,
            hasErrored: false
        }
    )
  }

  renderFailureResponse() {
      return(
        <div>
            <p>Global covid data temporarily not available. Please refresh in sometime.</p>
        </div>
      )
  }

  renderSuccessResponse(dataVisible) {
    if (dataVisible){
        return(
            <div>
                <table className='table table-sm font-weight-bold'>
                    <tbody>
                      <tr className='text-primary'>
                          <td> Total Confirmed </td>
                          <td>{this.state.totalConfirmedCases}</td>
                      </tr>
                      <tr className='text-danger'>
                          <td> Total Deaths </td>
                          <td>{this.state.totalDeathCases}</td>
                      </tr>
                      <tr className='text-success'>
                          <td> Total Recovered </td>
                          <td>{this.state.totalRecoveredCases}</td>
                      </tr>
                      <tr className='text-primary'>
                          <td> New Confirmed </td>
                          <td>{this.state.newConfirmedCases}</td>
                      </tr>
                      <tr className='text-danger'>
                          <td> New Deaths </td>
                          <td>{this.state.newDeathCases}</td>
                      </tr>
                      <tr className='text-success'>
                          <td> New Recovered </td>
                          <td>{this.state.newRecoveredCases}</td>
                      </tr>
                    </tbody>
                </table>
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

  componentDidMount() {
    this.renderGlobalSummary(this.props.globalSummaryUrl);
  }

  render() {
    let visible = this.state.isVisible;
    let errored = this.state.hasErrored;
    let covidData;
    if (!errored){
        covidData = this.renderSuccessResponse(visible);
    } else {
        covidData = this.renderFailureResponse();
    }
    return(
      <div>
        {covidData}
      </div>
    )
  }
}
export default GlobalCovidData;