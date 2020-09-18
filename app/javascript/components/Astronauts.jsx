import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class Astronauts extends React.Component {
  constructor(props) {
    super(props);
    this.onSuccessApi = this.onSuccessApi.bind(this);
    this.onFailureApi = this.onFailureApi.bind(this);
    this.renderSuccessResponse = this.renderSuccessResponse.bind(this);
    this.renderFailureResponse = this.renderFailureResponse.bind(this);
    this.state = {
      astronautDataVisible: false,
      numberOfAstronauts: null,
      people: null,
      astronaut_image: null
    }
  }

  onSuccessApi(obj) {
    this.setState(
      {
        astronautDataVisible: true,
        numberOfAstronauts: obj['astronaut_data']['number'],
        people: obj['astronaut_data']['people'],
        astronaut_image: obj['astronaut_image']
      }
    )
  }

  onFailureApi(error) {
    console.log(error);
    this.setState(
      {
        astronautDataVisible: false
      }
    )
  }

  renderSuccessResponse() {
    const astronauts = this.state.people;
    return (
      <div className="card-body">
        <p className="card-text text-center">There are <span><b>{this.state.numberOfAstronauts}</b></span> astronauts in space at this moment.</p>
        <table className="table table-hover table-dark">
          <thead>
            <tr>
              <th class="text-center" scope="col">Astronaut</th>
              <th class="text-center" scope="col">Spacecraft</th>
            </tr>
          </thead>
          <tbody>
            {
              astronauts.map((value, index) => {
                return (
                  <tr key={index}>
                    <td class="text-center">{value['name']}</td>
                    <td class="text-center">{value['craft']}</td>
                  </tr>
                )
              }
            )}
          </tbody>
        </table>
      </div>
    )
  }

  renderFailureResponse() {
    return(
      <div className="card-body">
        <h3 className="card-title">Data not available temporarily</h3>
      </div>
    )
  }

  renderAstronautData(astronautDataUrl) {
    fetch(astronautDataUrl, {headers: {'Content-Type': 'application/json',Accept: 'application/json'}})
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

  componentDidMount() {
    this.renderAstronautData(this.props.astronautDataUrl);
  }

  render() {
    const isVisible = this.state.astronautDataVisible;
    let astronautData;
    if(isVisible) {
      astronautData = this.renderSuccessResponse();
    } else {
      astronautData = this.renderFailureResponse();
    }
    return (
      <div className="card mb-3">
        <img src={this.state.astronaut_image} alt="AsteroidImage" className="card-img-top"/>
        {astronautData}
      </div>
    );
  }
}
export default Astronauts;
